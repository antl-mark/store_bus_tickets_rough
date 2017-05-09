require 'sqlite3'

class WorkWithDb

  def initialize
    @@database_file = 'store_bus_tickets_rough.sqlite'
  end

  def new_entry(user_info_hash)
    database = SQLite3::Database.open(@@database_file)
    database.results_as_hash = true
    database.execute("INSERT INTO user (#{user_info_hash.keys.join(',')})" +
                         "VALUES (#{('?,'*user_info_hash.keys.size).chomp(',')})", user_info_hash.values)
    insert_row_id = database.last_insert_row_id
    database.close
    insert_row_id
  end

  def info_from_db
    database = SQLite3::Database.open(@@database_file)
    database.results_as_hash = true
    request = "SELECT * FROM user ORDER by rowid ASC"
    statement = database.prepare(request)
    result = statement.execute!
    statement.close
    database.close
    result
  end

end