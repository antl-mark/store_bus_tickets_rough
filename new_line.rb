
class NewLine

  def create_new_line
    description = {}

    puts 'Enter your departure city'
    description[:departure_city] = STDIN.gets.chomp

    puts 'Enter the destination city'
    description[:arrival_city] = STDIN.gets.chomp

    puts 'Enter the date and time of departure (in format - DD.MM.YYYY h:m)'
    description[:departure_time] = STDIN.gets.chomp

    puts 'Enter the date and time of arrival (in format - DD.MM.YYYY h:m)'
    description[:arrival_time] = STDIN.gets.chomp

    puts 'Enter the maximum number of seats'
    description[:number_of_seats] = STDIN.gets.chomp

    description[:available_seats] = description[:number_of_seats]

    puts 'The new bus line created:'

    new_table = CreateTerminalTable.new
    new_table.tr_table("New bus rout: #{description[:departure_city].capitalize} - #{description[:arrival_city].capitalize}", description.keys, [description.values])

    puts 'Save this bus line? Please enter Yes/No'
    user_choice = STDIN.gets.chomp.downcase

    while user_choice != 'yes' && user_choice != 'no'
      puts 'Please enter Yes/No'
      user_choice = STDIN.gets.chomp.downcase
    end

    data_base = WorkWithDb.new
    data_base.new_entry(description, "buses") if user_choice == 'yes'
    puts 'The new bus line - created!'


  end


end