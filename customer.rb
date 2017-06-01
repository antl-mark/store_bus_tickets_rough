class Customer
  include Communication
  def initialize
    @user = DescribeOpportunities.new
    @user_choice = opportunities_list('customer')
    @column = column_name
    @city = {}
  end

  def customer_opportunities(user_name)
    case @user_choice
    when 1
      @city[:departure_city] = enter_data("Enter the departure city which interests you\n" \
                                              "Or enter \'all\' for view list of all bus routs")
      bus_list_table = ShowTerminalTable.new
      if @city[:departure_city] == 'all'
        bus_list_table.show_table('buses', 'List of all bus routes', @column)
      else
        bus_list_table.show_table('buses', 'List of selected bus routes', @column, @city)
      end
    when 2
      ticket = BuyTickets.new
      ticket.buy_tickets(@column, user_name)
    when 3
      puts 'todo...'
    when 4
      puts 'todo...'
    end
  end
end
