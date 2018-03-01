require_relative('../db/sql_runner.rb')

class Terrain_type
  attr_reader(:id, :terrain)

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @terrain = options['terrain']
  end

  def save()
    sql = "INSERT INTO terrain_types(
          terrain)
          VALUES ($1)
          RETURNING *;"
    values = [@terrain]
    terrain_type = SqlRunner.run(sql, values)[0]
    @id = terrain_type['id'].to_i
  end

  def update()
    sql = "UPDATE terrain_types SET (
          terrain)
          = ($1)
          WHERE id = $2
          RETURNING *;"
    values = [@terrain, @id]
    terrain_type = SqlRunner.run(sql, values)[0]
  end

  def delete()
    sql = "DELETE FROM terrain_types where id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end


  # CLASS METHODS

  def Terrain_type.find_all()
    sql = "SELECT * FROM terrain_types;"
    terrains_array = SqlRunner.run(sql)
    terrain_types = terrains_array.map {|terrain_hash| Terrain_type.new(terrain_hash)}
    return terrain_types
  end

  def Terrain_type.find_id(id)
    sql = "SELECT * FROM terrain_types WHERE id = $1"
    values = [id]
    terrain_hash = SqlRunner.run(sql, values)[0]
    terrain_type = Terrain_type.new(terrain_hash)
    return terrain_type
  end

  def Terrain_type.delete(id)
    sql = "DELETE FROM terrain_types where id = $1"
    values = [id]
    SqlRunner.run(sql, values)
  end

  def Terrain_type.delete_all()
    sql = "DELETE FROM terrain_types"
    SqlRunner.run(sql)
  end

end # end CLASS TERRAIN_TYPE
