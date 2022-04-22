require 'rspec/core'
require_relative '../name_worker'

RSpec.describe "name worker" do
  it "should put all names in file result.txt" do
    allow_any_instance_of(Kernel).to receive(:gets).and_return('10', '24', '15', '11', '20')
    names_worker
    expect(FileUtils.compare_file(FILE_RESULT, "file_worker_test/result1.txt")).to eq(true)
  end

  it "should put only names with age 24 to file and stop" do
    allow_any_instance_of(Kernel).to receive(:gets).and_return('24', '-1')
    names_worker
    expect(FileUtils.compare_file(FILE_RESULT, "file_worker_test/result2.txt")).to eq(true)
  end
end
