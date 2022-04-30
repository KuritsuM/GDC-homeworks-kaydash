require 'rspec/core'
require_relative '../web-client/App/Core/response'

RSpec.describe Response do
  context "status codes tests" do
    let(:response_200) do
      <<-STRING
HTTP/1.1 200
Content-Type: text/html; charset=utf8



      STRING
    end

    it "must return answer with 200 code" do
      response = Response.new('')

      expect(response.get_response).to eq(response_200)
    end

    it "must return answer with 200 code" do
      response = Response.new('', 200)

      expect(response.get_response).to eq(response_200)
    end

    let(:response_404) do
      <<-STRING
HTTP/1.1 404
Content-Type: text/html; charset=utf8



      STRING
    end

    it "must return answer with 404 code" do
      response = Response.new('', 404)

      expect(response.get_response).to eq(response_404)
    end
  end

  context "headers tests" do
    let(:response_headers) do
      <<-STRING
HTTP/1.1 200
Content-Type: text/html; charset=utf8
Connection: Closed



      STRING
    end

    it "should return response with html and Connection: Closed" do
      headers = {
        "Content-Type" => "text/html; charset=utf8",
        "Connection" => "Closed"
      }

      response = Response.new('', 200, headers)

      expect(response.get_response).to eq(response_headers)
    end
  end

  context "body tests" do
    let(:response_body) do
      <<-STRING
HTTP/1.1 200
Content-Type: text/html; charset=utf8


content
      STRING
    end

    it "returns response with body" do
      response = Response.new('content')

      expect(response.get_response).to eq(response_body)
    end
  end
end
