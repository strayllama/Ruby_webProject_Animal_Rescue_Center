require('pg')
class SqlRunner

  def SqlRunner.run(sql, values = [])
    begin
      db = PG.connect ( { dbname: 'rescue_center', host: 'localhost'})
      db.prepare('query', sql)
      result = db.exec_prepared('query', values)
    ensure
      db.close() if (db != nil)
    end

    return result
  end # def SQLRUNNER

end # end CLASS SQL RUNNER
