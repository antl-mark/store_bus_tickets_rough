module ValidationInput
  module Login
    def correct_input(identificator)
      user_input = enter_data("Enter your #{identificator}:")
      while invalid_user_input?(user_input, identificator)
        user_input = enter_data("Sorry, you entered an invalid #{identificator}. Please try again")
      end
      user_input
    end

    def invalid_user_input?(input, identificator)
      if identificator == 'name'
        input.empty? || !input.match(/[a-zA-Z]{3}/)
      elsif identificator == 'password'
        input.empty? || !input.match(/[a-zA-Z0-9]{6}/)
      end
    end
  end

  module Choice
    def invalid_user_choice?(action)
      user_choice = enter_data(action)
      while user_choice.empty? || !user_choice.match(/[0-9]/)
        user_choice = enter_data('Please make your choice')
      end
      user_choice
    end

    def confirmation(action)
      user_input = enter_data(action).downcase
      while user_input != 'yes' && user_input != 'no'
        user_input = enter_data('Please enter Yes/No').downcase
      end
      user_input
    end
  end
end
