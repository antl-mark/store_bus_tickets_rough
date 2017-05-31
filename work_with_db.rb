class WorkWithDb
  attr_reader :database_file
  def initialize
    @database_file = 'store_bus_tickets_rough.sqlite'
  end

  def new_entry(info_hash, table)
    database = SQLite3::Database.open(database_file)
    database.results_as_hash = true
    database.execute("INSERT INTO #{table} (#{info_hash.keys.join(',')})" \
                         "VALUES (#{('?,' * info_hash.keys.size).chomp(',')})", info_hash.values)
    insert_row_id = database.last_insert_row_id
    database.close
    insert_row_id
  end

  def info_from_db(table, sorting = nil)
    database = SQLite3::Database.open(database_file)
    database.results_as_hash = true
    if sorting == 'non-profit'
      request = "SELECT rowid, * FROM #{table} WHERE number_of_seats == available_seats ORDER by rowid ASC"
    elsif sorting.is_a?(Hash) && sorting.key?(:departure_city)
      request = "SELECT rowid, * FROM #{table} WHERE departure_city = '#{sorting[:departure_city]}' ORDER by departure_time ASC"
    else
      request = "SELECT rowid, * FROM #{table} ORDER by rowid ASC"
    end
    statement = database.prepare(request)
    result = statement.execute!
    statement.close
    database.close
    result
  end

  def refresh(table, id, departure_time, arrival_time)
    database = SQLite3::Database.open(database_file)
    database.results_as_hash = true
    request = "UPDATE #{table} SET departure_time = \"#{departure_time}\", arrival_time = \"#{arrival_time}\" WHERE rowid == #{id}"
    statement = database.prepare(request)
    result = statement.execute!
    statement.close
    database.close
    result
  end

  def delete(table, id)
    database = SQLite3::Database.open(database_file)
    database.results_as_hash = true
    request = "DELETE FROM #{table} WHERE rowid == #{id}"
    statement = database.prepare(request)
    result = statement.execute!
    statement.close
    database.close
    result
  end
end
