todos = [
  ["Send invoice", "money"],
  ["Clean room", "organize"],
  ["Pay rent", "money"],
  ["Arrange books", "organize"],
  ["Pay taxes", "money"],
  ["Buy groceries", "food"],
]

new_todos = []
new_todos = todos.map { |todo|
  visited_categories = []
  if !(visited_categories.include? todo[1])
    visited_categories.push(todo[1])
    categorized_todo = todos.map { |ct|
      if ct[1] == todo[1]
        ct[0]
      end
    }.select { |ft| ft != nil }
    [todo[1], categorized_todo]
  end
}

puts new_todos
