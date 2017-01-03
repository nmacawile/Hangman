selection = 50
count= 0
a = File.foreach("../5desk.txt").each_with_index { |word, index| word if index == selection }

puts a