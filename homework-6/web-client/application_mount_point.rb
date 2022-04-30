require_relative './App/Core/client_request_handler'
require_relative './App/src/Controller/cash_machine_controller'

routes = {
  '' => { requested_method: 'GET', controller: CashMachineController, method: :balance},
  '/deposite/{deposite_sum}' => { requested_method: 'GET', controller: CashMachineController, method: :deposite },
  '/withdraw/{withdraw_sum}' => { requested_method: 'GET', controller: CashMachineController, method: :withdraw }
}

ClientRequestHandler.new.run_client(routes)
