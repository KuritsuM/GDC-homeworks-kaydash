FILE_NAME = "homework1.txt"

def index
  return nil if !File.exist?(FILE_NAME)
  all_lines = []
  File.foreach(FILE_NAME) { |line| all_lines << line }
  all_lines
end

def find(id)
  return nil if !File.exist?(FILE_NAME)
  search_line = nil
  File.foreach(FILE_NAME).with_index { |line, index| search_line = line if index == id }
  search_line
end

def where(pattern)
  return nil if !File.exist?(FILE_NAME)
  pattern = Regexp.new pattern if !(pattern.class < Regexp)
  search_lines = []
  File.foreach(FILE_NAME) { |line| search_lines << line if pattern.match line }
  search_lines
end

def update(id, text)
  return nil if !File.exist?(FILE_NAME)

  file_read = File.open(FILE_NAME, "r")
  temp_file_write = File.open("temp_#{FILE_NAME}", "a")
  file_read.each.with_index do |line, index|
    index != id ? temp_file_write.write(line) : temp_file_write.write(text + "\n")
  end
  file_read.close
  temp_file_write.close

  temp_file_read = File.open("temp_#{FILE_NAME}", "r")
  temp_lines_counter = temp_file_read.inject(0) { |cnt| cnt + 1 }
  temp_file_read.close

  temp_file_write = File.open("temp_#{FILE_NAME}", "a")
  if id > temp_lines_counter
    (id - temp_lines_counter).downto(1) { temp_file_write.write("\n") }
    temp_file_write.write(text)
  end
  temp_file_write.close

  File.delete(FILE_NAME) if File.exist?(FILE_NAME)

  file_write = File.open(FILE_NAME, "a")
  temp_file_read = File.open("temp_#{FILE_NAME}", "r")

  temp_file_read.each { |line| file_write.write(line) }

  temp_file_read.close
  file_write.close

  File.delete("temp_#{FILE_NAME}") if File.exist?("temp_#{FILE_NAME}")
end

def delete(id)
  file_read = File.open(FILE_NAME, "r")
  temp_file_write = File.open("temp_#{FILE_NAME}", "a")
  file_read.each.with_index do |line, index|
    index != id ? temp_file_write.write(line) : temp_file_write.write("\n")
  end
  file_read.close
  temp_file_write.close

  temp_file_read = File.open("temp_#{FILE_NAME}", "r")
  temp_lines_counter = temp_file_read.inject(0) { |cnt| cnt + 1 }
  temp_file_read.close

  temp_file_write = File.open("temp_#{FILE_NAME}", "a")
  if id > temp_lines_counter
    (id - temp_lines_counter).downto(0) { temp_file_write.write("\n") }
    temp_file_write.write("\n")
  end
  temp_file_write.close

  File.delete(FILE_NAME) if File.exist?(FILE_NAME)

  file_write = File.open(FILE_NAME, "a")
  temp_file_read = File.open("temp_#{FILE_NAME}", "r")

  temp_file_read.each { |line| file_write.write(line) }

  temp_file_read.close
  file_write.close

  File.delete("temp_#{FILE_NAME}") if File.exist?(FILE_NAME)
end
