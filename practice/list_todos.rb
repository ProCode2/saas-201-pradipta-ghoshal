require "./connect_db.rb"
require "./todo.rb"

connect_db!

puts Todo.where(completed: true).to_displayable_list
