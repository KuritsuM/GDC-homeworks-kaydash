require_relative '../Repository/cash_machine'

class CashMachineService
  def initialize
    @cash_machine = CashMachine.new
  end

  def balance
    @cash_machine.balance
  end

  def withdraw(sum)
    result = @cash_machine.withdraw(sum)
    @cash_machine.save
    result
  end

  def deposite(sum)
    result = @cash_machine.deposite(sum)
    @cash_machine.save
    result
  end
end