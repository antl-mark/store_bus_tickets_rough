
class DeleteBusLine

  def delete_line(column)

    array_of_key = [:id, :departure_city, :arrival_city, :departure_time, :arrival_time, :number_of_seats, :available_seats]
    bus_line_hash = {}
    array_row = []

    table_of_non_profit_line = ShowTerminalTable.new
    table_of_non_profit_line.show_table("buses", 'non-profit', 'Non-profit buses routs list', column)

    non_profit_buses = table_of_non_profit_line.data_of_buses

    puts 'Please enter the id of bus line that you want to refresh'
    user_choice = STDIN.gets.chomp


    while user_choice == '' || !user_choice.match(/[0-9]/)
      puts 'Please make your choice'
      user_choice = STDIN.gets.chomp
    end


    non_profit_buses.each_with_index do |row, i|
      array_row << Hash[array_of_key.zip(row)]
    end

    array_row.each do |elem|
      bus_line_hash[elem[:id]] = elem
    end

    bus_line_hash.each_pair do |key, row|
      if key == user_choice.to_i
        title_table_of_delete_bus_line = "Bus line - ID #{row[:id]}: #{row[:departure_city].capitalize} - #{row[:arrival_city].capitalize} - will be deleted!"
        table_of_delete_bus_line = CreateTerminalTable.new
        table_of_delete_bus_line.tr_table(title_table_of_delete_bus_line, row.keys, [row.values])

        puts 'Delete this bus line?'
        user_input = STDIN.gets.chomp.downcase

        while user_input != 'yes' && user_input != 'no'
          puts 'Please enter Yes/No'
          user_input = STDIN.gets.chomp.downcase
        end

        if user_input == 'yes'
          refr_base_row = WorkWithDb.new
          refr_base_row.delete("buses", user_choice)
        end

      end
    end

  end

end




