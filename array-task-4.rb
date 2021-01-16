todos = [
  ["Send invoice", "money"],
  ["Clean room", "organize"],
  ["Pay rent", "money"],
  ["Arrange books", "organize"],
  ["Pay taxes", "money"],
  ["Buy groceries", "food"],
]

new_todos = []

todos.each { |todo|
  categorized_todo = new_todos.find { |t| t[0] == todo[1] }
  if categorized_todo == nil
    new_todos.push([todo[1], [todo[0]]])
  else
    categorized_todo[1].push(todo[0])
  end
}

new_todos.each { |todo|
  puts "#{todo[0]}:"
  todo[1].each { |sub_todo|
    puts "\t#{sub_todo}"
  }
}
