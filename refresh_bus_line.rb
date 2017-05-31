class RefreshBusLine
  include Communication
  def initialize
    super
  end

  def refresh_line(column)
    bus_list_table = ShowTerminalTable.new
    bus_list_table.show_table('buses', 'Non-profit buses routs list', column, 'non-profit')
    non_profit_buses = bus_list_table.data_of_buses

    user_choice = enter_data('Please enter the id of bus line that you want to refresh')
    while user_choice == '' || !user_choice.match(/[0-9]/)
      user_choice = enter_data('Please make your choice')
    end

    multi_hash_of_row = make_hash_id_to_row(non_profit_buses)
    multi_hash_of_row.each_pair do |key, row|
      next unless key == user_choice.to_i
      row[:departure_time] = (DateTime.parse(row[:departure_time]) + Rational('1')).strftime('%d.%m.%Y %H:%M')
      row[:arrival_time] = (DateTime.parse(row[:arrival_time]) + Rational('1')).strftime('%d.%m.%Y %H:%M')
      title_refr_bus_line_table = "Refreshed schedule of bus line - ID #{row[:id]}: #{row[:departure_city].capitalize} - #{row[:arrival_city].capitalize}"
      refr_bus_line_table = CreateTerminalTable.new
      refr_bus_line_table.tr_table(title_refr_bus_line_table, row.keys, [row.values])
      user_input = enter_data('Refresh the schedule of this bus line?').downcase
      while user_input != 'yes' && user_input != 'no'
        user_input = enter_data('Please enter Yes/No').downcase
      end
      if user_input == 'yes'
        refr_base_row = WorkWithDb.new
        refr_base_row.refresh('buses', user_choice, row[:departure_time], row[:arrival_time])
      end
    end
  end
end
