require 'rspec/core'
require_relative '../task-1/cash_machine'

RSpec.describe "cash machine class" do
  before { File.delete('./balance.txt') if File.exist?('./balance.txt')}

  let(:creation_test) do
    <<-STRING
Введите желаемую операцию. Доступные значения: [B/D/W/Q]
Нынешний баланс: 100.0
Введите желаемую операцию. Доступные значения: [B/D/W/Q]
Нынешний баланс будет сохранён в файл ./balance.txt
    STRING
  end

  it "show current balance" do
    allow_any_instance_of(Kernel).to receive(:gets).and_return('b', 'Q')

    expect{ CashMachine.new.init }.to output(creation_test).to_stdout
  end

  let(:deposite_test) do
    <<-STRING
Введите желаемую операцию. Доступные значения: [B/D/W/Q]
Введите сумму депозита:
Введите желаемую операцию. Доступные значения: [B/D/W/Q]
Введите сумму депозита:
Сумма депозита не может быть меньше, чем 0.
Введите желаемую операцию. Доступные значения: [B/D/W/Q]
Нынешний баланс будет сохранён в файл ./balance.txt
    STRING
  end

  it "adds correct and incorrect deposite" do
    allow_any_instance_of(Kernel).to receive(:gets).and_return('d', '1000', 'D', '-1000000', 'q')

    expect{ CashMachine.new.init }.to output(deposite_test).to_stdout
  end

  let(:withdraw_test) do
    <<-STRING
Введите желаемую операцию. Доступные значения: [B/D/W/Q]
Введите сумму для снятия:
Вы не можете снять больше, чем у Вас на балансе.
Введите желаемую операцию. Доступные значения: [B/D/W/Q]
Введите сумму для снятия:
Сумма снятия не может быть меньше нуля.
Введите желаемую операцию. Доступные значения: [B/D/W/Q]
Введите сумму для снятия:
Введите желаемую операцию. Доступные значения: [B/D/W/Q]
Нынешний баланс будет сохранён в файл ./balance.txt
    STRING
  end

  it "make correct and incorrect withdraw" do
    allow_any_instance_of(Kernel).to receive(:gets).and_return('w', '10000000', 'W', '-10000000', 'w', '5', 'q')

    expect{ CashMachine.new.init }.to output(withdraw_test).to_stdout
  end
end