#Пишемо скелет програми.

#Людина запускає програму, їй пропонується зайти в систему.

#Користувач вводить імя і пароль, ці дані записуються в хеш,
# але програма незнає хто намагається увійти в систему

#Необхідно перевірити чи введена інформація є в базі даних,
# якщо є - створити обєкт класу, який відповідає ролі, приписаній в базі введеній інформації,
# якшо відсутня - записати в базу данних нового користувача, роль по замовчуванню - custumer,
# після чого створити обєкт класу, який відповідає даній ролі

#Підгружаємо необхідні файли
require_relative 'load_files'
LoadFiles.config

#Створюєм обєкт користувача
user = User.new
verified_user = user.login('')          # повертає хещ - {:name=>"anatoliy", :password=>"qwerty123", :role=>""}

#Витягуємо з бази даних з таблиці user, відомості про всіх зареєстрованих користувачів
data_base = WorkWithDb.new
data_of_users = data_base.info_from_db("user", '')

#Спочатку потрібно перевірити чи введені дані співпадають з даними бази
user_data_exist = data_of_users.find_all {|row| row.include?(verified_user[:name]) && row.include?(verified_user[:password])}.flatten

if user_data_exist.empty?
  puts "Sorry, this account not exists.\nPlease register your account"  #Якщо введені дані неспівпадають з даними бази
  verified_user = user.login('custumer')                        #проводимо повторний ввід даних - реєстрація
  data_base.new_entry(verified_user, "user")                #створюємо новий запис про користувача в базі даних
  abort "Your account has been registered."
else
  if user_data_exist.include?('admin')                                   #Якщо введені дані співпадають з зареєстрованими користувачами
    current_user = Admin.new                                             #створюємо користувача відповідно його ролі, відміченій в базі даних
    current_user.admin_opportunities
  else
    current_user = Custumer.new
    current_user.custumer_opportunities
  end
end



