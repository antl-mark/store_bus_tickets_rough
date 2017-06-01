class NewLine
  include Communication
  include ValidationInput::Choice
  def initialize
    @description = {}
    @data_base = WorkWithDb.new
    @new_table = CreateTerminalTable.new
  end

  def create_new_line
    @description[:departure_city] = enter_data('Enter your departure city')
    @description[:arrival_city] = enter_data('Enter the destination city')
    @description[:departure_time] = enter_data('Enter the date and time of departure (in format - DD.MM.YYYY h:m)')
    @description[:arrival_time] = enter_data('Enter the date and time of arrival (in format - DD.MM.YYYY h:m)')
    @description[:number_of_seats] = enter_data('Enter the maximum number of seats')
    @description[:available_seats] = @description[:number_of_seats]
    @new_table.tr_table("New bus rout: #{@description[:departure_city].capitalize} - #{@description[:arrival_city].capitalize}", @description.keys, [@description.values])
    user_confir = confirmation('Save this bus line? Please enter Yes/No')
    @data_base.new_entry(@description, 'buses') if user_confir == 'yes'
    puts 'The new bus line - created!'
  end
end
