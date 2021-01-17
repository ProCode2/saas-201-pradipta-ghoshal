require "active_record"

class Todo < ActiveRecord::Base
  def due_today?
    due_date == Date.today
  end

  def to_displayable_string
    display_status = completed ? "[X]" : "[ ]"
    display_date = due_today? ? nil : due_date
    "#{id}. #{display_status} #{todo_text} #{display_date}"
  end

  def self.to_displayable_list
    all.map { |todo| todo.to_displayable_string }
  end

  # return all the todos that are overdue
  def self.overdue
    all.where("due_date < :date", { date: Date.today }).to_displayable_list
  end

  # return all the todos that are due today
  def self.due_today
    all.where(due_date: Date.today).to_displayable_list
  end

  # return all the todos that are due later
  def self.due_later
    all.where("due_date > :date", { date: Date.today }).to_displayable_list
  end

  # print the todo list according to the given template
  def self.show_list
    puts "My Todo-list"
    puts "\n"
    puts "Overdue"
    puts overdue
    puts "\n\n"
    puts "Due Today"
    puts due_today
    puts "\n\n"
    puts "Due Later"
    puts due_later
  end

  # add a todo to the :todos table
  def self.add_task(task)
    create!(todo_text: task[:todo_text], due_date: Date.today + task[:due_in_days], completed: false)
  end

  # mark a todo as complete
  def self.mark_as_complete!(id)
    todo = find(id)
    todo.completed = true
    todo.save
    return todo
  end
end
