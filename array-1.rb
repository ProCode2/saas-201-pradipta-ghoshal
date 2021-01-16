nums = [2, 4, 200, 400]

# creating a new array with whatever map returns
new_nums = nums.map {|n| n * 125 }

# iterates over every item in the array
new_nums.each {|x| puts x}
