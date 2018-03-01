require_relative('../db/sql_runner.rb')
require_relative('location.rb')
require_relative('terrain_type.rb')


class Animal
  attr_reader(:id, :name, :species, :type_id, :admission_date, :health,
              :location_id, :age, :sex, :size, :colour)

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @species = options['species']
    @type_id = options['type_id'].to_i
    @admission_date = options['admission_date']
    @health = options['health']
    @location_id = options['location_id'].to_i
    @age = options['age']
    @sex = options['sex']
    @size = options['size']
    @colour = options['colour']
  end

  def save()
    sql = "INSERT INTO animals(
          name, species, type_id, admission_date,
          health, location_id, age, sex, size, colour)
          VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10)
          RETURNING *;"
    values = [@name, @species, @type_id, @admission_date, @health, @location_id, @age, @sex, @size, @colour]
    animal = SqlRunner.run(sql, values)[0]
    @id = animal['id'].to_i
  end

  def update()
    sql = "UPDATE animals SET (
          name, species, type_id, admission_date,
          health, location_id, age, sex, size, colour)
          = ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10)
          WHERE id = $11
          RETURNING *;"
    values = [@name, @species, @type_id, @admission_date, @health, @location_id, @age, @sex, @size, @colour, @id]
    animal = SqlRunner.run(sql, values)[0]
  end

  def delete()
    sql = "DELETE FROM animals where id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def location()
    sql = "SELECT * FROM locations WHERE id = $1"
    location_hash = SqlRunner.run(sql, [@location_id])[0]
    location = Location.new(location_hash)
    return location
  end

  def suitable_locations()
    all_locations = Location.find_all()
    suitable_locations = []
    all_locations.each do |location|
      if (Terrain_type.find_id(@type_id).terrain() == "Land") && (location.land() == "Yes")
        suitable_locations << location
      elsif (Terrain_type.find_id(@type_id).terrain() == "Tree top") && (location.tree_top() == "Yes")
        suitable_locations << location
      elsif (Terrain_type.find_id(@type_id).terrain() == "Aquatic") && (location.aquatic() == "Yes")
        suitable_locations << location
      end
    end
    return suitable_locations
  end

  def change_location_id(new_location_id)
    @location_id = new_location_id.to_i
  end


  # CLASS METHODS

  def Animal.healthy()
    sql = "SELECT * FROM animals WHERE health = $1 and location_id = $2;"
    rescue_center_id = Location.rescue_center_id().to_i
    values = [100, rescue_center_id]
    animals_array = SqlRunner.run(sql, values)
    healthy_animals = animals_array.map {|animal_hash| Animal.new(animal_hash)}
    return healthy_animals
  end

  def Animal.ill()
    sql = "SELECT * FROM animals WHERE health < $1;"
    values = [100]
    animals_array = SqlRunner.run(sql, values)
    ill_animals = animals_array.map {|animal_hash| Animal.new(animal_hash)}
    return ill_animals
  end

  def Animal.find_id(id)
    sql = "SELECT * FROM animals WHERE id = $1"
    values = [id]
    animal_hash = SqlRunner.run(sql, values)[0]
    animal = Animal.new(animal_hash)
    return animal
  end

  def Animal.find_all()
    sql = "SELECT * FROM animals ORDER BY admission_date;"
    animals_array = SqlRunner.run(sql)
    animals = animals_array.map {|animal_hash| Animal.new(animal_hash)}
    return animals
  end

  def Animal.find_all_sort_species()
    sql = "SELECT * FROM animals ORDER BY species;"
    animals_array = SqlRunner.run(sql)
    animals = animals_array.map {|animal_hash| Animal.new(animal_hash)}
    return animals
  end

  def Animal.find_all_sort_sex()
    sql = "SELECT * FROM animals ORDER BY sex;"
    animals_array = SqlRunner.run(sql)
    animals = animals_array.map {|animal_hash| Animal.new(animal_hash)}
    return animals
  end

  def Animal.find_all_sort_type()
    sql = "SELECT * FROM animals ORDER BY type_id;"
    animals_array = SqlRunner.run(sql)
    animals = animals_array.map {|animal_hash| Animal.new(animal_hash)}
    return animals
  end

  def Animal.delete(id)
    sql = "DELETE FROM animals where id = $1"
    values = [id]
    SqlRunner.run(sql, values)
  end

  def Animal.delete_all()
    sql = "DELETE FROM animals"
    SqlRunner.run(sql)
  end

end # end CLASS ANIMAL
