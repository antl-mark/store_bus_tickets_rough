class User
  include Communication
  include ValidationInput::Login
  def login
    enter_data_flow
  end

  def registration
    enter_data_flow
  end

  private

  def enter_data_flow
    user_name_input = correct_input('name')
    user_password_input = correct_input('password')
    { name: user_name_input, password: user_password_input }
  end
end
