require_relative '../../Core/controller'

class Index < Controller
  def index
    Response.new("id -> #{@arguments["id"]}")
  end

  def start_page
    Response.new("This is start page")
  end
end