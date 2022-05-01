require_relative 'unreadable_url_worker'
require_relative 'readable_url_worker'

class URLWorkerFactory
  def self::make_url_worker(url, method, readable = true)
    if readable
      return ReadableURLWorker.new(url, method)
    end
    UnreadableURLWorker.new(url, method)
  end
end