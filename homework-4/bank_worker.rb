FILE_NAME_BALANCE = "balance.txt"
DEFAULT_BALANCE = 100.0
PRECISION = 2

def deposite(deposite_sum)
  if File.exist?(FILE_NAME_BALANCE)
    if deposite_sum < 0
      puts "Сумма депозита не может быть меньше нуля. Отмена операции."
      return
    end

    current_balance = balance
    new_deposite_sum = (current_balance + deposite_sum).round(PRECISION)
    File.write(FILE_NAME_BALANCE, new_deposite_sum)
    new_deposite_sum
  end
end

def withdraw(withdraw_sum)
  if File.exist?(FILE_NAME_BALANCE)
    current_balance = balance

    if withdraw_sum < 0
      puts "Снимаемая сумма не может быть меньше нуля. Отмена операции."
    end

    if current_balance < withdraw_sum
      puts "Вы пытаетесь снять больше, чем у вас есть на балансе. Отмена операции."
      return
    end

    new_deposite_sum = (current_balance - withdraw_sum).round(PRECISION)
    File.write(FILE_NAME_BALANCE, new_deposite_sum)
    new_deposite_sum
  end
end

def balance
  if File.exist?(FILE_NAME_BALANCE)
    File.read(FILE_NAME_BALANCE).to_f
  end
end

def bank_input
  File.write(FILE_NAME_BALANCE, DEFAULT_BALANCE) if !File.exist?(FILE_NAME_BALANCE)

  while true
    puts "Выберите операцию. Допустимые значения: [D/W/B/Q]"
    input = gets.chomp

    case input.downcase
    when "d"
      puts "Введите сумму депозита:"
      deposite(gets.chomp.to_f)
    when "w"
      puts "Введите сумму для снятия:"
      withdraw(gets.chomp.to_f)
    when "b"
      puts "Текущий баланс: #{balance}"
    when "q"
      return
    else
      puts "Операция не найдена."
    end
  end
end
