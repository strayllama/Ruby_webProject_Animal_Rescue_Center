require_relative('../db/sql_runner.rb')

class Location
  attr_reader(:id, :name)

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

  def save()
    sql = "INSERT INTO locations(
          name)
          VALUES ($1)
          RETURNING *;"
    values = [@name]
    location = SqlRunner.run(sql, values)[0]
    @id = location['id'].to_i
  end



# CLASS METHODS

def Location.find_id(id)
  sql = "SELECT * FROM locations WHERE id = $1"
  values = [id]
  location_hash = SqlRunner.run(sql, values)[0]
  location = Location.new(location_hash)
  return location
end

def Location.find_all()
  sql = "SELECT * FROM locations"
  animals_array = SqlRunner.run(sql)
  return animals = animals_array.each {|animal_hash| Animal.new(animal_hash)}
end

  def Location.delete_all()
    sql = "DELETE FROM locations"
    SqlRunner.run(sql)
  end
end # end CLASS LOCATION
