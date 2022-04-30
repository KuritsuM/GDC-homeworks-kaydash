require 'rspec/core'
require_relative '../web-client/App/Core/url_worker'

RSpec.describe URLWorker do
  it "check that url identical" do
    url_woker = URLWorker.new("/some_url", "GET")
    expect(url_woker.url_match?("/some_url", { requested_method: "GET" })).to eq(true)
  end

  it "check that url non identical" do
    url_woker = URLWorker.new("/some_url", "GET")
    expect(url_woker.url_match?("/some_other_url", { requested_method: "GET" })).to eq(false)
  end

  it "check that url non identical" do
    url_woker = URLWorker.new("/some_url/15", "GET")
    expect(url_woker.url_match?("/some_url", { requested_method: "GET" })).to eq(false)
  end

  it "check that url with argument identical" do
    url_woker = URLWorker.new("/some_url/16", "GET")
    expect(url_woker.url_match?("/some_url/{id}", { requested_method: "GET" })).to eq(true)
  end

  it "check that url with argument non identical" do
    url_woker = URLWorker.new("/some_url/16", "GET")
    expect(url_woker.url_match?("/some_url/{id}/{x}", { requested_method: "GET" })).to eq(false)
  end

  it "check that url with another requested method non identical" do
    url_woker = URLWorker.new("/some_url/16", "POST")
    expect(url_woker.url_match?("/some_url/{id}", { requested_method: "GET" })).to eq(false)
  end

  it "should return arguments as hash after last correct url" do
    url_worker = URLWorker.new("/index/15/16", "GET")
    url_worker.url_match?("/index/{id}/{date}", { requested_method: "GET" })

    should_return = { "id" => "15", "date" => "16" }

    expect(url_worker.get_url_arguments).to eq(should_return)
  end
end
