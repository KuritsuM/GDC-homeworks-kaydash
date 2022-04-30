class Response
  private

  def form_answer_headers
    (@headers.inject('') { |answer, headers| answer += "#{headers[0]}: #{headers[1]}\n" }) + "\n\n"
  end

  public

  def initialize(body = '', status_code = 200, headers = { 'Content-Type' => 'text/html; charset=utf8' })
    @body = body
    @status_code = status_code
    @headers = headers
  end

  def get_response
    answer_head = "HTTP/1.1 #{@status_code}\n"
    answer_header = form_answer_headers
    answer_body = "#{@body}\n"

    answer_head + answer_header + answer_body
  end
end
