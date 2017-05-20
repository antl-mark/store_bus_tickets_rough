
class RefreshBusLine
  def refresh_line(column)
    array_of_key = [:id, :departure_city, :arrival_city, :departure_time, :arrival_time, :number_of_seats, :available_seats]
    bus_line_hash = {}
    array_row = []

    table_of_non_profit_line = ShowTerminalTable.new
    table_of_non_profit_line.show_table('buses', 'non-profit', 'Non-profit buses routs list', column)

    non_profit_buses = table_of_non_profit_line.data_of_buses

    puts 'Please enter the id of bus line that you want to refresh'
    user_choice = STDIN.gets.chomp

    while user_choice == '' || !user_choice.match(/[0-9]/)
      puts 'Please make your choice'
      user_choice = STDIN.gets.chomp
    end

    non_profit_buses.each_with_index do |row, _i|
      array_row << Hash[array_of_key.zip(row)]
    end

    array_row.each do |elem|
      bus_line_hash[elem[:id]] = elem
    end

    bus_line_hash.each_pair do |key, row|
      next unless key == user_choice.to_i
      row[:departure_time] = (DateTime.parse(row[:departure_time]) + Rational('1')).strftime('%d.%m.%Y %H:%M')
      row[:arrival_time] = (DateTime.parse(row[:arrival_time]) + Rational('1')).strftime('%d.%m.%Y %H:%M')

      title_refr_bus_line_table = "Refreshed schedule of bus line - ID #{row[:id]}: #{row[:departure_city].capitalize} - #{row[:arrival_city].capitalize}"
      refr_bus_line_table = CreateTerminalTable.new
      refr_bus_line_table.tr_table(title_refr_bus_line_table, row.keys, [row.values])

      puts 'Refresh the schedule of this bus line?'
      user_input = STDIN.gets.chomp.downcase

      while user_input != 'yes' && user_input != 'no'
        puts 'Please enter Yes/No'
        user_input = STDIN.gets.chomp.downcase
      end
      if user_input == 'yes'
        refr_base_row = WorkWithDb.new
        refr_base_row.refresh('buses', user_choice, row[:departure_time], row[:arrival_time])
      end
    end
  end
end
