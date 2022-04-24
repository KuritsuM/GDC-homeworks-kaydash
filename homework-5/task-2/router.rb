module Resource
  def connection(routes)
    if routes.nil?
      puts "No route matches for #{self}"
      return
    end

    loop do
      print 'Choose verb to interact with resources (GET/POST/PUT/DELETE) / q to exit: '
      verb = gets.chomp
      break if verb == 'q'

      action = nil

      if verb == 'GET'
        print 'Choose action (index/show) / q to exit: '
        action = gets.chomp
        break if action == 'q'
      end


      action.nil? ? routes[verb].call : routes[verb][action].call
    end
  end
end

class PostsController
  extend Resource

  def initialize
    @posts = []
  end

  def index
    @posts.each_with_index { |post, index| puts "#{index}: #{post}" }
  end

  def show
    puts "Enter your post index: "
    index = gets.chomp.to_i

    if index < 0 || index > @posts.length
      puts "Invalide post index. It must be more or equal 0, and less then count of all posts.
            Current posts count: #{@posts.length}"
      return
    end

    puts @posts[index]
  end

  def create
    puts "Enter your post text: "
    @posts << gets.chomp
  end

  def update
    puts "Enter your post index: "
    index = gets.chomp.to_i

    if index < 0 || index > @posts.length
      puts "Invalide post index. It must be more or equal 0, and less then count of all posts.
            Current posts count: #{@posts.length}"
      return
    end

    puts "Enter new post text: "
    text = gets.chomp

    @posts[index] = text
  end

  def destroy
    puts "Enter your post index: "
    index = gets.chomp.to_i

    if index < 0 || index > @posts.length
      puts "Invalide post index. It must be more or equal 0, and less then count of all posts.
            Current posts count: #{@posts.length}"
      return
    end

    @posts.delete_at(index)
  end
end

class Router
  def initialize
    @routes = {}
  end

  def init
    resources(PostsController, 'posts')

    loop do
      print 'Choose resource you want to interact (1 - Posts, 2 - Comments, q - Exit): '
      choise = gets.chomp

      PostsController.connection(@routes['posts']) if choise == '1'
      break if choise == 'q'
    end

    puts 'Good bye!'
  end

  def resources(klass, keyword)
    controller = klass.new
    @routes[keyword] = {
      'GET' => {
        'index' => controller.method(:index),
        'show' => controller.method(:show)
      },
      'POST' => controller.method(:create),
      'PUT' => controller.method(:update),
      'DELETE' => controller.method(:destroy)
    }
  end
end

router = Router.new

router.init
