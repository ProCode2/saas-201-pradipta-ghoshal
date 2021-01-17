names = [["Jhumpa", "Lahiri"], ["J. K", "Rowling"], ["Devdutt", "Pattanaik"]]

new_names = names.map { |name| "#{name[0]} #{name[1]}"}

puts new_names
