require 'rspec/core'
require 'net/http'
require_relative '../web-client/App/src/Controller/cash_machine_controller'

#before test you must start application_mount_point, otherwise all test will show failure
RSpec.describe CashMachineController, :type => :request do
  context "balance test" do
    it "returns balance" do
      url = URI("http://127.0.0.1:3000")
      Net::HTTP.start(url.host, url.port) do |http|
        request = Net::HTTP::Get.new url

        response = http.request request

        expect(response.body).to include("Current balance")
      end
    end

    it "returns balance" do
      url = URI("http://127.0.0.1:3000/balance")
      Net::HTTP.start(url.host, url.port) do |http|
        request = Net::HTTP::Get.new url

        response = http.request request

        expect(response.body).to include("Current balance")
      end
    end
  end

  context "withdraw test" do
    it "should return error because we didn't specify withdraw sum" do
      url = URI("http://127.0.0.1:3000/withdraw")
      Net::HTTP.start(url.host, url.port) do |http|
        request = Net::HTTP::Get.new url

        response = http.request request

        expect(response.body).to include("You didn't specify how much to withdraw")
      end
    end

    it "should return error because we withdraw sum less then zero" do
      url = URI("http://127.0.0.1:3000/withdraw?value=-100")
      Net::HTTP.start(url.host, url.port) do |http|
        request = Net::HTTP::Get.new url

        response = http.request request

        expect(response.body).to include("Withdraw sum can't be less, then 0. Current balance: ")
      end
    end

    it "should return error because we withdraw sum much more then balance" do
      url = URI("http://127.0.0.1:3000/withdraw?value=100000000")
      Net::HTTP.start(url.host, url.port) do |http|
        request = Net::HTTP::Get.new url

        response = http.request request

        expect(response.body).to include("You can't withdraw more, then you have noew. Current balance: ")
      end
    end

    it "should successful withdraw sum" do
      url = URI("http://127.0.0.1:3000/withdraw?value=10")
      Net::HTTP.start(url.host, url.port) do |http|
        request = Net::HTTP::Get.new url

        response = http.request request

        expect(response.body).to include("Withdraw success. Current balance: ")
      end
    end
  end

  context "deposite test" do
    it "should return error if we didn't specify deposite sum" do
      url = URI("http://127.0.0.1:3000/deposite")
      Net::HTTP.start(url.host, url.port) do |http|
        request = Net::HTTP::Get.new url

        response = http.request request

        expect(response.body).to include("You didn't specify how much to deposite")
      end
    end

    it "should return error if our deposite less then 0" do
      url = URI("http://127.0.0.1:3000/deposite?value=-100")
      Net::HTTP.start(url.host, url.port) do |http|
        request = Net::HTTP::Get.new url

        response = http.request request

        expect(response.body).to include("Deposite sum can't be less, then 0. Current balance: ")
      end
    end

    it "should return error if we didn't specify deposite sum" do
      url = URI("http://127.0.0.1:3000/deposite?value=100")
      Net::HTTP.start(url.host, url.port) do |http|
        request = Net::HTTP::Get.new url

        response = http.request request

        expect(response.body).to include("Deposite success. Current balance: ")
      end
    end
  end
end
