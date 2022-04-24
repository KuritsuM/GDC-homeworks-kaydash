require 'rspec/core'
require_relative '../homework_methods'

RSpec.describe 'greetings' do
  it "returns greeting for person above or equal 18" do
    age = Random.new.rand(65) + 18
    name, surname = 'Дмитрий', 'Кайдаш'

    expect(greetings(name, surname, age)).to eq("Привет, #{name} #{surname}. Самое время заняться делом!")
  end

  it "returns greeting for person under 18" do
    age = Random.new.rand(18)
    name, surname = 'Дмитрий', 'Кайдаш'

    expect(greetings(name, surname, age)).to eq("Привет, #{name} #{surname}. Тебе меньше 18 лет, но начать учиться программировать никогда не рано")
  end
end
