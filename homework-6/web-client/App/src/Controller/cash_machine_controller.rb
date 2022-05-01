require_relative '../../Core/controller'
require_relative '../Service/cash_machine_service'

class CashMachineController < Controller
  def balance
    cash_machine_service = CashMachineService.new
    result = cash_machine_service.balance

    Response.new(result)
  end

  def withdraw
    result = "You didn't specify how much to withdraw"

    if @arguments.key?("value")
      cash_machine_service = CashMachineService.new
      result = cash_machine_service.withdraw(@arguments["value"].to_f)
    end

    Response.new(result)
  end

  def deposite
    result = "You didn't specify how much to deposite"

    if @arguments.key?("value")
      cash_machine_service = CashMachineService.new
      result = cash_machine_service.deposite(@arguments["value"].to_f)
    end

    Response.new(result)
  end
end