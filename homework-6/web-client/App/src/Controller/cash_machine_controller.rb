require_relative '../../Core/controller'
require_relative '../Service/cash_machine_service'

class CashMachineController < Controller
  def balance
    cash_machine_service = CashMachineService.new
    result = cash_machine_service.balance

    Response.new(result)
  end

  def withdraw
    cash_machine_service = CashMachineService.new
    result = cash_machine_service.withdraw(@arguments["withdraw_sum"].to_f)

    Response.new(result)
  end

  def deposite
    cash_machine_service = CashMachineService.new
    result = cash_machine_service.deposite(@arguments["deposite_sum"].to_f)

    Response.new(result)
  end
end