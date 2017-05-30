module Communication
  def enter_data(message)
    puts message
    STDIN.gets.chomp
  end

  def opportunities_list(role)
    @user.opportunities(role)
  end

  def column_name
    @user.ticket_options
  end
end
