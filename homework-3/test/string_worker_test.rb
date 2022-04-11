require 'rspec/core'
require_relative '../homework_methods'

RSpec.describe "string_worker" do
  it "returns 64 if input abcdCS" do
    expect(string_worker('abcdCS')).to eq(64)
  end

  it "returns CSdcba if input abcdSC" do
    expect(string_worker('abcdSC')).to eq('CSdcba')
  end
end
