require_relative('../db/sql_runner.rb')

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

  def delete()
    sql = "DELETE FROM locations where id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
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
    locaitons = locations_array.map {|location_hash| Location.new(location_hash)}
    return locaitons
  end

  def Location.delete_all()
    sql = "DELETE FROM locations"
    SqlRunner.run(sql)
  end
end # end CLASS LOCATION
