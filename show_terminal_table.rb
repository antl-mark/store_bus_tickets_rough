
class ShowTerminalTable

  attr_reader :data_of_buses

  def initialize
    @data_of_buses = nil

  end

  def show_table(name_of_table, profit, title_of_table, column)

    data_base = WorkWithDb.new
    @data_of_buses = data_base.info_from_db(name_of_table, profit)
    new_table = CreateTerminalTable.new
    new_table.tr_table(title_of_table, column, @data_of_buses)

  end


end

