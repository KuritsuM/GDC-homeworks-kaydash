class CashMachine
  BALANCE_FILE = "App/src/Assets/Balance/balance.txt"
  attr_reader :balance

  def initialize
    if File.exist?(BALANCE_FILE)
      @balance = File.read(BALANCE_FILE).to_f
    else
      @balance = 100.0
    end
  end

  def balance
    "Current balance: #{@balance}"
  end

  def deposite(deposite_sum)
    if deposite_sum < 0
      return "Deposite sum can't be less, then 0. Current balance: #{@balance}"
    end

    @balance += deposite_sum
    "Deposite success. Current balance: #{@balance}"
  end

  def withdraw(withdraw_sum)
    if withdraw_sum < 0
      return "Withdraw sum can't be less, then 0. Current balance: #{@balance}"
    end
    if withdraw_sum > @balance
      return "You can't withdraw more, then you have noew. Current balance: #{@balance}"
    end

    @balance -= withdraw_sum
    "Withdraw success. Current balance: #{@balance}"
  end

  def save
    File.write(BALANCE_FILE, @balance)
  end
end

#CashMachine.new.init
