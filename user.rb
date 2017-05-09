
class User
  def initialize
    @user_name = nil
    @user_password = nil
    @user_role = nil
  end

  def login(role_input)
    puts 'Enter youre name:'
    user_name_input = STDIN.gets.chomp

    while user_name_input == '' || !user_name_input.match(/[a-zA-Z]{4}/)
      puts 'Sorry, you entered an invalid name. Please try again'
      user_name_input = STDIN.gets.chomp
    end

    puts 'Enter password:'
    user_password_input = STDIN.gets.chomp

    while user_password_input == '' || !user_password_input.match(/[a-zA-Z0-9]{6}/)
      puts 'Sorry, you entered an invalid password. Please try again'
      user_password_input = STDIN.gets.chomp
    end

    @user_name = user_name_input
    @user_password = user_password_input
    @user_role = role_input if role_input != nil

    return {:name => @user_name, :password => @user_password, :role => @user_role}

  end

end