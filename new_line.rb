class NewLine
  include Communication
  def initialize
    @description = {}
  end

  def create_new_line
    @description[:departure_city] = enter_data('Enter your departure city')
    @description[:arrival_city] = enter_data('Enter the destination city')
    @description[:departure_time] = enter_data('Enter the date and time of departure (in format - DD.MM.YYYY h:m)')
    @description[:arrival_time] = enter_data('Enter the date and time of arrival (in format - DD.MM.YYYY h:m)')
    @description[:number_of_seats] = enter_data('Enter the maximum number of seats')
    @description[:available_seats] = @description[:number_of_seats]
    puts 'The new bus line created:'
    new_table = CreateTerminalTable.new
    new_table.tr_table("New bus rout: #{@description[:departure_city].capitalize} - #{@description[:arrival_city].capitalize}", @description.keys, [@description.values])
    user_choice = enter_data('Save this bus line? Please enter Yes/No').downcase
    while user_choice != 'yes' && user_choice != 'no'
      user_choice = enter_data('Please enter Yes/No').downcase
    end
    data_base = WorkWithDb.new
    data_base.new_entry(description, 'buses') if user_choice == 'yes'
    puts 'The new bus line - created!'
  end
end
