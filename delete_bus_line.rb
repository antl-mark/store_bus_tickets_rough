class DeleteBusLine < Filter
  include Communication
  def initialize
    super
  end

  def delete_line(column)
    bus_list_table = ShowTerminalTable.new
    bus_list_table.show_table('buses', 'Non-profit buses routs list', column, 'non-profit')
    non_profit_buses = bus_list_table.data_of_buses

    user_choice = enter_data('Please enter the id of bus line that you want to delete')
    while user_choice == '' || !user_choice.match(/[0-9]/)
      user_choice = enter_data('Please make your choice')
    end

    multi_hash_of_row = make_hash_id_to_row(non_profit_buses)
    multi_hash_of_row.each_pair do |key, row|
      next unless key == user_choice.to_i
      title_table_of_delete_bus_line = "Bus line - ID #{row[:id]}: #{row[:departure_city].capitalize} - #{row[:arrival_city].capitalize} - will be deleted!"
      table_of_delete_bus_line = CreateTerminalTable.new
      table_of_delete_bus_line.tr_table(title_table_of_delete_bus_line, row.keys, [row.values])
      user_input = enter_data('Delete this bus line?').downcase
      while user_input != 'yes' && user_input != 'no'
        user_input = enter_data('Please enter Yes/No').downcase
      end
      if user_input == 'yes'
        refr_base_row = WorkWithDb.new
        refr_base_row.delete('buses', user_choice)
      end
    end
  end
end
