class BuyTickets
  def initialize
    @city = {}
    @array_of_key = %i[id departure_city arrival_city departure_time arrival_time number_of_seats available_seats]
    @bus_routs_filter_hash = {}
    @array_row = []
    @busy_place = []
  end

  def buy_tickets(column)
    @city[:departure_city] = enter_data("Enter the departure city which interests you.\n")

    bus_list_table = ShowTerminalTable.new
    bus_list_table.show_table('buses', @city, 'List of selected bus routes', column)

    bus_routs_filter = bus_list_table.data_of_buses

    puts 'Enter the ID bus trip that interests you.'

    user_choice = STDIN.gets.chomp

    while user_choice == '' || !user_choice.match(/[0-9]/)
      puts 'Please make your choice'
      user_choice = STDIN.gets.chomp
    end

    bus_routs_filter.each_with_index do |row, _i|
      @array_row << Hash[@array_of_key.zip(row)]
    end

    @array_row.each do |elem|
      @bus_routs_filter_hash[elem[:id]] = elem
    end

    @bus_routs_filter_hash.each_pair do |key, row|
      next unless key == user_choice.to_i
      next unless row[:available_seats].to_i != 0
      puts "Please choose the № of place (01-#{row[:number_of_seats]})"
      chosen_place = STDIN.gets.chomp
      while chosen_place == '' || !chosen_place.match(/[0-9]{2}/)
        puts 'Please make your choice'
        chosen_place = STDIN.gets.chomp

        @busy_place << chosen_place
      end
    end
  end
end
