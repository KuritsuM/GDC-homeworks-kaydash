require 'rspec/core'
require_relative '../bank_worker'

RSpec.describe 'bank worker methods' do
  before { File.delete("balance.txt") if File.exist?("balance.txt") }

  let(:creation_test) do
    <<-STRING
Выберите операцию. Допустимые значения: [D/W/B/Q]
Текущий баланс: 100.0
Выберите операцию. Допустимые значения: [D/W/B/Q]
    STRING
  end

  it "should create a new file with a deposite 100.0" do
    allow_any_instance_of(Kernel).to receive(:gets).and_return('b', 'Q')

    expect{ bank_input }.to output(creation_test).to_stdout
  end

  let(:deposite_test) do
    <<-STRING
Выберите операцию. Допустимые значения: [D/W/B/Q]
Введите сумму депозита:
Выберите операцию. Допустимые значения: [D/W/B/Q]
Введите сумму депозита:
Выберите операцию. Допустимые значения: [D/W/B/Q]
    STRING
  end

  it "should check if method take upper and lower case for withdraw input" do
    allow_any_instance_of(Kernel).to receive(:gets).and_return('D', '100.0', 'd', '100.0', 'q')

    expect{ bank_input }.to output(deposite_test).to_stdout
  end

  let(:withdraw_test) do
    <<-STRING
Выберите операцию. Допустимые значения: [D/W/B/Q]
Введите сумму для снятия:
Выберите операцию. Допустимые значения: [D/W/B/Q]
Введите сумму для снятия:
Выберите операцию. Допустимые значения: [D/W/B/Q]
    STRING
  end

  it "should check if method take upper and lower case for deposite input" do
    allow_any_instance_of(Kernel).to receive(:gets).and_return('W', '1', 'w', '1', 'Q')
    expect{ bank_input }.to output(withdraw_test).to_stdout
  end

  let(:balance_test) do
    <<-STRING
Выберите операцию. Допустимые значения: [D/W/B/Q]
Текущий баланс: 100.0
Выберите операцию. Допустимые значения: [D/W/B/Q]
Текущий баланс: 100.0
Выберите операцию. Допустимые значения: [D/W/B/Q]
    STRING
  end

  before { File.delete("balance.txt") if File.exist?("balance.txt") }

  it "should check if method take upper and lower case for balance input" do
    allow_any_instance_of(Kernel).to receive(:gets).and_return('B', 'b', 'q')

    expect{ bank_input }.to output(balance_test).to_stdout
  end

  let(:input_correctness) do
    <<-STRING
Выберите операцию. Допустимые значения: [D/W/B/Q]
Операция не найдена.
Выберите операцию. Допустимые значения: [D/W/B/Q]
Операция не найдена.
Выберите операцию. Допустимые значения: [D/W/B/Q]
Операция не найдена.
Выберите операцию. Допустимые значения: [D/W/B/Q]
    STRING
  end

  it "should check if input correct" do
    allow_any_instance_of(Kernel).to receive(:gets).and_return('a', 'ar', '115f','q')

    expect{ bank_input }.to output(input_correctness).to_stdout
  end

  let(:deposite_lower_then_zero) do
    <<-STRING
Выберите операцию. Допустимые значения: [D/W/B/Q]
Введите сумму депозита:
Сумма депозита не может быть меньше нуля. Отмена операции.
Выберите операцию. Допустимые значения: [D/W/B/Q]
    STRING
  end

  it "should check that deposite can't be less then zero" do
    allow_any_instance_of(Kernel).to receive(:gets).and_return('d', '-15', 'q')

    expect{ bank_input }.to output(deposite_lower_then_zero).to_stdout
  end

  let(:withdraw_lower_then_zero_and_upper_then_balance) do
    <<-STRING
Выберите операцию. Допустимые значения: [D/W/B/Q]
Введите сумму для снятия:
Снимаемая сумма не может быть меньше нуля. Отмена операции.
Выберите операцию. Допустимые значения: [D/W/B/Q]
Введите сумму для снятия:
Вы пытаетесь снять больше, чем у вас есть на балансе. Отмена операции.
Выберите операцию. Допустимые значения: [D/W/B/Q]
    STRING
  end

  it "should check that withdraw can't be less then zero and more then balance" do
    allow_any_instance_of(Kernel).to receive(:gets).and_return('w', '-1000000', 'w', '100000000', 'q')

    expect{ bank_input }.to output(withdraw_lower_then_zero_and_upper_then_balance).to_stdout
  end
end
