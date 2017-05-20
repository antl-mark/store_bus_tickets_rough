class DescribeOpportunities
  attr_reader :ticket_options

  def initialize
    @ticket_options = %w(ID departure_city arrival_city departure_time arrival_time number_of_seats available_seats)
  end

  def opportunities(role)
    if role == 'admin'
      puts "Hello. You have the following opportunities:\n" \
           "1. View a list of bus routs.\n" \
           "2. Add a new bus line.\n" \
           "3. Refresh bus line\n" \
           "4. Remove bus line.\n" \
           "5. View a list of ticket buyers.\n" \
           'What youre choice?'

    elsif role == 'customer'
      puts "Hello. You have the following opportunities:\n" \
           "1. View a list of bus routs.\n" \
           "2. Buy the ticket.\n" \
           "3. View a list of purchased tickets\n" \
           'What youre choice?'
    end

    user_choice = STDIN.gets.chomp.to_i

    while user_choice < 1 || user_choice > 5
      puts 'Please make your choice.'
      user_choice = STDIN.gets.chomp.to_i
    end

    user_choice
  end
end
