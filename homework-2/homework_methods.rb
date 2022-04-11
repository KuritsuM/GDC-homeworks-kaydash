def greetings(name, surname, age)
  if age < 18
    "Привет, #{name} #{surname}. Тебе меньше 18 лет, но начать учиться программировать никогда не рано"
  else
    "Привет, #{name} #{surname}. Самое время заняться делом!"
  end
end

def foobar(first, second)
  if [first, second].include? 20
    second
  else
    first + second
  end
end
