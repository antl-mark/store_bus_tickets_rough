class BuyTickets
  include Communication
  def initialize
    @city = {}
    @busy_place = []
    super
  end

  def buy_tickets(column)
    @city[:departure_city] = enter_data("Enter the departure city which interests you\n")
    bus_list_table = ShowTerminalTable.new
    bus_list_table.show_table('buses', 'List of selected bus routes', column, @city)
    bus_routs_filter = bus_list_table.data_of_buses

    user_choice = enter_data('Enter the ID bus line that interests you')
    while user_choice == '' || !user_choice.match(/[0-9]/)
      user_choice = enter_data('Please make your choice')
    end

    multi_hash_of_row = make_hash_id_to_row(bus_routs_filter)
    multi_hash_of_row.each_pair do |key, row|
      next unless key == user_choice.to_i
      next unless row[:available_seats].to_i != 0
      chosen_place = enter_data("Please choose the № of place (01-#{row[:number_of_seats]})")
      while chosen_place == '' || !chosen_place.match(/[0-9]{2}/)
        chosen_place = enter_data('Please make your choice')
        @busy_place << chosen_place
      end
    end
  end
end
