require 'rspec/core'
require_relative '../homework_methods'

RSpec.describe "input_pockemons" do
  it "returns array of hashes" do
    allow_any_instance_of(Kernel).to receive(:gets).and_return('2', 'Pickachu Yellow', 'Slowpock Pink')

    final_hash = [
      { name: 'Pickachu', color: 'Yellow'},
      { name: 'Slowpock', color: 'Pink'}
    ]

    expect(input_pockemons).to eq(final_hash)
  end

  it "returns array of hashes and wait for input >= 1" do
    allow_any_instance_of(Kernel).to receive(:gets).and_return('abcd', '0', '3', 'Pickachu Yellow', 'Slowpock Pink', 'Bulbasaur Green')

    final_hash = [
      { name: 'Pickachu', color: 'Yellow'},
      { name: 'Slowpock', color: 'Pink'},
      { name: 'Bulbasaur', color: 'Green'}
    ]

    expect(input_pockemons).to eq(final_hash)
  end
end
