require 'rspec/core'
require_relative '../web-client/App/Core/unreadable_url_worker'

RSpec.describe UnreadableURLWorker do
  it "should say that URLs equals" do
    url_worker = UnreadableURLWorker.new("/some_url?value=100", "GET")

    expect(url_worker.url_match?('/some_url', { requested_method: "GET" })).to eq(true)
  end

  it "should say that URLs equals" do
    url_worker = UnreadableURLWorker.new("/some_url", "GET")

    expect(url_worker.url_match?('/some_url', { requested_method: "GET" })).to eq(true)
  end

  it "should say that URLs equals" do
    url_worker = UnreadableURLWorker.new("/some_url/", "GET")

    expect(url_worker.url_match?('/some_url', { requested_method: "GET" })).to eq(true)
  end

  it "should return arguments as hash" do
    arguments = { "value" => "100", "page" => "2" }
    url_worker = UnreadableURLWorker.new("/some_url?value=100&page=2", "GET")
    url_worker.url_match?('/some_url', { requested_method: "GET" })

    expect(url_worker.get_url_arguments).to eq(arguments)
  end
end
