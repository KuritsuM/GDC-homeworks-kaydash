require_relative './App/Core/client_request_handler'
require_relative './App/src/Controller/cash_machine_controller'

=begin

# it also will works
# human-readable url variant
routes = {
  '/' => { requested_method: 'GET', controller: CashMachineController, method: :balance},
  '/balance' => { requested_method: 'GET', controller: CashMachineController, method: :balance},
  '/deposite/{value}' => { requested_method: 'GET', controller: CashMachineController, method: :deposite },
  '/withdraw/{value}' => { requested_method: 'GET', controller: CashMachineController, method: :withdraw }
}
=end

routes = {
  '/' => { requested_method: 'GET', controller: CashMachineController, method: :balance},
  '/balance' => { requested_method: 'GET', controller: CashMachineController, method: :balance},
  '/deposite' => { requested_method: 'GET', controller: CashMachineController, method: :deposite },
  '/withdraw' => { requested_method: 'GET', controller: CashMachineController, method: :withdraw }
}

ClientRequestHandler.new(readable_url: false).run_client(routes)
