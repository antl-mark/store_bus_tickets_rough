class Customer
  def customer_opportunities
    city = {}

    user = DescribeOpportunities.new
    user_choice = user.opportunities('customer')
    column = user.ticket_options
    case user_choice
    when 1
      puts  "Enter the departure city which interests you.\n" \
            "Or enter \'all\' for view list of all bus routs."
      city[:departure_city] = STDIN.gets.chomp.downcase

      bus_list_table = ShowTerminalTable.new
      if city[:departure_city] == 'all'
        bus_list_table.show_table('buses', '', 'List of all bus routes', column)
      else
        bus_list_table.show_table('buses', city, 'List of selected bus routes', column)
      end

    when 2
      ticket = BuyTickets.new
      ticket.buy_tickets(column)

    when 3
      puts 'todo...'
    when 4
      puts 'todo...'
    end
  end
end
