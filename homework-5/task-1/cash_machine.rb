class CashMachine
  BALANCE_FILE = "balance.txt"
  attr_reader :balance

  private

  def initialize
    if File.exist?(BALANCE_FILE)
      @balance = File.read(BALANCE_FILE).to_f
    else
      @balance = 100.0
    end
  end

  def deposite(deposite_sum)
    if deposite_sum < 0
      puts "Сумма депозита не может быть меньше, чем 0."
      return
    end

    @balance += deposite_sum
  end

  def withdraw(withdraw_sum)
    if withdraw_sum < 0
      puts "Сумма снятия не может быть меньше нуля."
      return
    end
    if withdraw_sum > @balance
      puts "Вы не можете снять больше, чем у Вас на балансе."
    end

    @balance -= withdraw_sum
  end

  def quit
    File.write(BALANCE_FILE, @balance)
  end

  public

  def init
    loop do
      puts "Введите желаемую операцию. Доступные значения: [B/D/W/Q]"
      operation = gets.chomp.downcase

      case operation
      when 'b'
        puts "Нынешний баланс: #{@balance}"
      when 'd'
        puts "Введите сумму депозита:"
        deposite_sum = gets.to_f
        deposite(deposite_sum)
      when 'w'
        puts "Введите сумму для снятия:"
        withdraw_sum = gets.to_f
        withdraw(withdraw_sum)
      when 'q'
        puts "Нынешний баланс будет сохранён в файл #{BALANCE_FILE}"
        quit
        return
      else
        puts "Операция не найдена. Попробуйте снова!"
      end
    end
  end
end

CashMachine.new.init
