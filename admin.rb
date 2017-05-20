
class Admin

  def admin_opportunities

    user = DescribeOpportunities.new
    user_choice = user.opportunities('admin')
    column = user.ticket_options

    case user_choice
      when 1
        bus_list_table = ShowTerminalTable.new
        bus_list_table.show_table("buses", '', 'Bus routs list', column)
      when 2
        new_bus_line = NewLine.new
        new_bus_line.create_new_line
      when 3
        non_profit_bus_line = RefreshBusLine.new
        non_profit_bus_line.refresh_line(column)
      when 4
        delete_bus_line = DeleteBusLine.new
        delete_bus_line.delete_line(column)
      when 5
        puts 'todo...'
    end

  end

end




