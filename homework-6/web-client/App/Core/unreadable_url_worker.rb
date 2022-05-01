require 'uri'

class UnreadableURLWorker
  attr_reader :found_url
  private

  def initialize(url, method)
    @url = url
    @clean_url = clean_url
    @method = method
  end

  def get_raw_arguments
    if @url.include?("?")
      "?#{URI(@url).query}"
    else
      ""
    end
  end

  def get_unreadable_url_arguments
    url = URI(@url)
    decoded_uri = URI.decode_www_form(url.query)
    Hash[decoded_uri]
  end

  def clean_url
    @url.delete_suffix(get_raw_arguments)
  end

  public

  def url_match?(url, additional_info = { requested_method: "GET" })
    if @clean_url != url
      if @clean_url != "#{url}/"
        return false
      end
    end

    if @method != additional_info[:requested_method]
      return false
    end

    @found_url = url
    true
  end

  def get_url_arguments
    if @url.include?("?")
      get_unreadable_url_arguments
    else
      {}
    end
  end
end
