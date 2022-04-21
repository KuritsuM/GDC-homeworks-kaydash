require 'rspec/core'
require_relative '../file_worker'

RSpec.describe 'crud methods for file' do
  let(:file_index) do
    <<-STRING
1.first
2.second
3.third
    STRING
  end

  before { File.delete(FILE_NAME) }
  before { File.write(FILE_NAME, file_index) }

  it "show all file lines" do
    result = [ "1.first\n", "2.second\n", "3.third\n" ]
    expect(index).to eq(result)
  end

  it "find 1 line of file" do
    expect(find(1)).to eq("2.second\n")
  end

  it "find line that match pattern" do
    expect(where('2')).to eq(["2.second\n"])
  end

  it "adds line on the specified position" do
    update(2, "updated")

    expect(FileUtils.compare_file(FILE_NAME, "file_worker_test/update.txt")).to eq(true)
    #expect(File.read(FILE_NAME)).to eq(File.read("file_worker_test/update.txt"))
  end

  it "deletes line on the specified position" do
    delete(2)

    expect(FileUtils.compare_file(FILE_NAME, "file_worker_test/delete.txt")).to eq(true)
    #expect(File.read(FILE_NAME)).to eq(File.read("file_worker_test/update.txt"))
  end
end
