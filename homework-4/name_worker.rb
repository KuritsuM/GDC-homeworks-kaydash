FILE_NAME_NAMES = "names.txt"
FILE_RESULT = "results.txt"

def names_worker
  File.delete(FILE_RESULT) if File.exist?(FILE_RESULT)

  inputed_ages = []

  while (age = gets.chomp.to_i)
    if inputed_ages.include?(age)
      puts "Вы уже выводили людей с таким возрастом в файл results. Повторите ввод или введите -1."
      next
    end
    inputed_ages << age
    break if age == -1

    file = File.open(FILE_NAME_NAMES, "r")
    result_file = File.open(FILE_RESULT, "a")
    file.each do |line|
      current_name = line.chomp.split(' ')
      result_file.write(line) if current_name[2].to_i == age
    end
    result_file.close
    file.close

    file = File.open(FILE_NAME_NAMES, "r")
    result_file = File.open(FILE_RESULT, "r")
    file_size = file.inject(0) { |cnt| cnt + 1 }
    result_file_size = result_file.inject(0) { |cnt| cnt + 1 }

    file.close
    result_file.close

    puts file_size.to_s + ' ' + result_file_size.to_s

    break if file_size <= result_file_size
  end
end
