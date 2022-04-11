def string_worker(str)
  if str.reverse[0..1].reverse == "CS"
    2**str.length
  else
    str.reverse
  end
end

def input_pockemons
  puts "Сколько покемонов вы хотите ввести?: "
  how_much = gets.to_i

  while how_much < 1
    puts "Минимум 1 покемон. Введите количество снова: "
    how_much = gets.to_i
  end

  pockemons = []
  1.upto(how_much) do
    puts "Введите имя покемона и его цвет: "
    pockemon = gets.chomp
    pockemon = pockemon.split(' ')

    pockemons << { name: pockemon[0], color: pockemon[1] }
  end

  pockemons
end
