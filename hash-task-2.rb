todos = [
  ["Send invoice", "money"],
  ["Clean room", "organize"],
  ["Pay rent", "money"],
  ["Arrange books", "organize"],
  ["Pay taxes", "money"],
  ["Buy groceries", "food"],
]

todo_hash = todos.map { |todo| todo[1] }.uniq.inject({}) do |memo, category|
  memo[category.to_sym] = []
  memo
end

todos.map do |todo|
  todo_hash[todo[1].to_sym].push(todo[0])
end

print todo_hash

=begin
first try:

todos.inject({}) do |memo, todo|
  memo[todo[1].to_sym].push(todo[0])
  memo
end

gives NoMethodError
=end
