require "rspec/core"
require_relative '../homework_methods'

RSpec.describe "method foobar" do
  it "returns sum of numbers pair if no one of them equals to 20" do
    first, second = Random.new.rand(19), Random.new.rand(19)

    expect(foobar(first, second)).to eq(first + second)
  end

  it "returns 20 if one of the arguments equals to 20" do
    first, twelve = Random.new.rand(19), 20

    expect(foobar(first, twelve)).to eq(twelve)
    expect(foobar(twelve, twelve)).to eq(twelve)
  end
end
