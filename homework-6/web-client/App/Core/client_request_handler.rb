require 'socket'
require_relative 'url_worker'
require_relative 'response'
require_relative '../src/Controller/index'

class ClientRequestHandler
  private

  def call_required_method(route, method)
    url_worker = URLWorker.new(route, method)

    @routes.each_key { |key| url_worker.url_match?(key, @routes[key]) }

    if url_worker.found_url
      controller = @routes[url_worker.found_url][:controller].new(url_worker.get_url_arguments)
      response = controller.send(@routes[url_worker.found_url][:method])
      response.get_response
    else
      Response.new("Not found", 404).get_response
    end
  end

  public

  def initialize(ip = '127.0.0.1', port = 3000)
    @server = TCPServer.new(ip, port)
  end

  def run_client(routes)
    @routes = routes

    while (connection = @server.accept)
      request = connection.gets
      method, route = request.split(' ')

      response = call_required_method(route, method)

      connection.print(response)
      connection.close
    end
  end
end
