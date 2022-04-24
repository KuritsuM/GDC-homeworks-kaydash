require_relative 'homework_methods'

puts "Введите ваше имя и фамилию: "
name, surname = gets.chomp
puts "Введите ваш возраст: "
age = gets.to_i

puts greetings(name, surname, age)
puts "Foobar: ", foobar(10, 15)
puts "Foobar: ", foobar(10, 20)
