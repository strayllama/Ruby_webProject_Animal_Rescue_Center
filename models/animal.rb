require_relative('../db/sql_runner.rb')

class Animal
  attr_reader(:id, :name, :species, :admission_date, :progress, :location_id)

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @species = options['species']
    @admission_date = options['admission_date']
    @progress = options['progress']
    @location_id = options['location_id']
  end

  def save()
    sql = "INSERT INTO animals(
          name, species, admission_date,
          progress, location_id)
          VALUES ($1, $2, $3, $4, $5)
          RETURNING *;"
    values = [@name, @species, @admission_date, @progress, @location_id]
    animal = SqlRunner.run(sql, values)[0]
    @id = animal['id'].to_i
  end

# CLASS METHODS

def Animal.healthy()
  sql = "SELECT * FROM animals WHERE progress = $1;"
  values = [100]
  animals_array = SqlRunner.run(sql, values)
  healthy_animals = animals_array.map {|animal_hash| Animal.new(animal_hash)}
  return healthy_animals
end

def Animal.ill()
  sql = "SELECT * FROM animals WHERE progress < $1;"
  values = [100]
  animals_array = SqlRunner.run(sql, values)
  ill_animals = animals_array.map {|animal_hash| Animal.new(animal_hash)}
  return ill_animals
end

def Animal.find_id(id)
  sql = "SELECT * FROM animals WHERE progress = $1"
  values = [id]
  animals_array = SqlRunner.run(sql, values)
  healthy_animals = animals_array.map {|animal_hash| Animal.new(animal_hash)}
  return healthy_animals
end

  def Animal.find_all()
    sql = "SELECT * FROM animals"
    animals_array = SqlRunner.run(sql)
     animals = animals_array.map {|animal_hash| Animal.new(animal_hash)}
     return animals
  end

  def Animal.delete_all()
    sql = "DELETE FROM animals"
    SqlRunner.run(sql)
  end

end # end CLASS ANIMAL
