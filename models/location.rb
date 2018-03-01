require_relative('../db/sql_runner.rb')
require_relative('animal.rb')

class Location
  attr_reader(:id, :name, :description, :land, :tree_top, :aquatic)

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @description = options['description']
    @land = options['land']
    @tree_top = options['tree_top']
    @aquatic = options['aquatic']
  end

  def save()
    sql = "INSERT INTO locations(
          name, description, land, tree_top, aquatic)
          VALUES ($1, $2, $3, $4, $5)
          RETURNING *;"
    values = [@name, @description, @land, @tree_top, @aquatic]
    location = SqlRunner.run(sql, values)[0]
    @id = location['id'].to_i
  end

  def update()
    sql = "UPDATE locations SET(
          name, description, land, tree_top, aquatic)
          = ($1, $2, $3, $4, $5)
          WHERE id = $6
          RETURNING *;"
    values = [@name, @description, @land, @tree_top, @aquatic, @id]
    location = SqlRunner.run(sql, values)[0]
  end

  def delete()
    sql = "DELETE FROM locations where id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def animals()
    sql = "SELECT * FROM animals WHERE location_id = $1"
    animals_hasharray = SqlRunner.run(sql, [@id])
    animals = animals_hasharray.map { |animal_hash| Animal.new(animal_hash) }
    return animals
  end

  def caters_for()
    string = ""
    if (@land == "Yes")
      if (@tree_top == "Yes")
        if (@aquatic == "Yes")
          string = "Caters for Land, Tree top and Aquatic animals."
        else
          string = "Caters for Land and Tree top animals."
        end
      elsif (@aquatic == "Yes")
        string = "Caters for Land and Aquatic animals."
      else
        string = "Caters for Land animals."
      end
    else
      if (@tree_top == "Yes")
        if (@aquatic == "Yes")
          string = "Caters for Tree top and Aquatic animals."
        else
          string = "Caters for Tree top animals."
        end
      else
        string = "Caters for Aquatic animals."
      end
    end
    
    return string
  end

  # CLASS METHODS

  def Location.rescue_center_id()
    sql = "SELECT * FROM locations WHERE name = $1"
    values = ["Rescue Center"]
    location_hash = SqlRunner.run(sql, values)[0]
    location = Location.new(location_hash)
    return location.id()
  end

  def Location.find_id(id)
    sql = "SELECT * FROM locations WHERE id = $1"
    values = [id]
    location_hash = SqlRunner.run(sql, values)[0]
    location = Location.new(location_hash)
    return location
  end

  def Location.find_all()
    sql = "SELECT * FROM locations"
    locations_array = SqlRunner.run(sql)
    locations = locations_array.map {|location_hash| Location.new(location_hash)}
    return locations
  end

  def Location.delete_all()
    sql = "DELETE FROM locations"
    SqlRunner.run(sql)
  end
end # end CLASS LOCATION
