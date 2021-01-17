class Student
  def initialize(roll_no, name)
    @roll_no = roll_no
    @name = name
    @is_enrolled = false
  end

  # Getter
  def enrolled?
    @is_enrolled
  end

  # Setter
  def enroll
    @is_enrolled = true
  end

  # Getter
  def roll_no
    @roll_no
  end

  # Getter
  def name
    @name
  end
end

# initializing an object
student = Student.new(15, "Raj")

puts student.name
puts student.roll_no
puts student.enrolled?
puts student.enroll
