class URLWorker
  attr_reader :url, :found_url
  private

  def initialize(url, method)
    @url = url
    @method = method
    @url_signature = make_url_signature(@url)
  end

  def argument?(url_part)
    (url_part.start_with?("{") && url_part.end_with?("}"))
  end

  def make_url_signature(url)
    url_signature = []

    url.split('/').each do |url_part|
      url_signature << (argument?(url_part) ? { url_part => "argument" } : { url_part => "link" })
    end

    url_signature
  end

  def url_signature_match?(url)
    url_signature = make_url_signature(url)
    is_url_same = true

    if url_signature.length != @url_signature.length
      return false
    end

    url_signature.each.with_index do |url_signature_part, index|
      signature_part = @url_signature[index].to_a[0]
      url_signature_part = url_signature_part.to_a[0]

      if url_signature_part[0] != signature_part[0] && url_signature_part[1] == "link"
        is_url_same = false
      end
    end

    is_url_same
  end

  def make_name_from_signature(raw_name)
    name = raw_name[1..-1][0..-2]
  end

  def make_value_from_signature(index)
    @url_signature.to_a[index].to_a[0][0]
  end

  def make_url_arguments
    arguments = []
    @correct_url_signature.each.with_index do |signature, index|
      if signature.values[0] == "argument"
        arguments << { make_name_from_signature(signature.keys[0]) => make_value_from_signature(index) }
      end
    end

    arguments_hash = {}
    arguments.each { |value| arguments_hash.merge!(value) }

    arguments_hash
  end

  public

  def url_match?(checking_url, additional_info)
    if !url_signature_match?(checking_url)
      return false
    end

    if @method != additional_info[:requested_method]
      return false
    end

    @correct_url_signature = make_url_signature(checking_url)
    @found_url = checking_url

    true
  end

  def get_url_arguments
    make_url_arguments
  end
end
