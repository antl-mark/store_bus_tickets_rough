require_relative 'load_files'
LoadFiles.config

user = User.new
verified_user = user.login

data_base = WorkWithDb.new
data_of_users = data_base.info_from_db('user')
user_data_exist = data_of_users.find_all { |row| row.include?(verified_user[:name]) && row.include?(verified_user[:password]) }

if user_data_exist.empty?
  puts 'Sorry, this account not exists.\nPlease register your account'
  verified_user = user.registration.merge(role: 'customer')
  data_base.new_entry(verified_user, 'user')
  abort 'Your account has been registered.'
else
  admin = user_data_exist.detect { |data| data.include?('admin') }
  if admin
    current_user = Admin.new
    current_user.admin_opportunities
  else
    current_user = Customer.new
    current_user.customer_opportunities(verified_user[:name])
  end
end
