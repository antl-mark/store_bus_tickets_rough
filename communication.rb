module Communication
  def enter_data(message)
    puts message
    STDIN.gets.chomp
  end
end
