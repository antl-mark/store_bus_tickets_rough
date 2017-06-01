class BuyTickets < Filter
  include Communication
  include ValidationInput::Choice
  def initialize
    @city = {}
    @busy_place = []
    @data_base = WorkWithDb.new
    @new_table = CreateTerminalTable.new
    super
  end

  def buy_tickets(column, name)
    @city[:departure_city] = enter_data("Enter the departure city which interests you\n")
    @data_of_buses = @data_base.info_from_db('buses', @city)
    @new_table.tr_table('Non-profit buses routs list', column, @data_of_buses)
    multi_hash_of_row = make_hash_id_to_row(@data_of_buses)
    user_choice = invalid_user_choice?('Please enter the ID bus line that interests you')
    multi_hash_of_row.each_pair do |key, row|
      next unless key == user_choice.to_i
      next unless row[:available_seats].to_i != 0
      chosen_place = invalid_user_choice?("Please choose the number of place (01-#{row[:number_of_seats]})")
      @busy_place = chosen_place.split(', ')
      description = Hash[user_name: name, buses: user_choice, purchased_tickets: @busy_place.join(', ')]
      @new_table.tr_table("You have chosen tickets: #{@busy_place.join(', ')}; on bus line: #{row[:departure_city].capitalize} - #{row[:arrival_city].capitalize}", description.keys, [description.values])
      user_confir = confirmation('If everything is correct, confirm selection. Please enter Yes/No')
      if user_confir == 'yes'
        @data_base.new_entry(description, 'list_of_customers')
        @data_base.refresh('buses', user_choice, row[:departure_time], row[:arrival_time], (row[:number_of_seats] - @busy_place.size))
      end
    end
  end
end
