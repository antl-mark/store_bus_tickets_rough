require_relative 'communication'
class User
  include Communication

  def login
    enter_data_flow
  end

  def registration
    enter_data_flow
  end

  private

  def enter_data_flow
    user_name_input = enter_data('Enter your name:')

    while invalid_user_name?(user_name_input)
      user_name_input = enter_data('Sorry, you entered an invalid name. Please try again')
    end

    user_password_input = enter_data('Enter password:')

    while invalid_user_password?(user_password_input)
      user_password_input = enter_data('Sorry, you entered an invalid password. Please, try again')
    end

    { name: user_name_input, password: user_password_input }
  end

  def invalid_user_name?(input)
    input.empty? || !input.match(/[a-zA-Z]{3}/)
  end

  def invalid_user_password?(input)
    input.empty? || !input.match(/[a-zA-Z0-9]{6}/)
  end
end
