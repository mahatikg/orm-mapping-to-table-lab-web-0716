class Student

attr_accessor  :name, :grade

  def initialize(name, grade)
    @name = name
    @grade = grade
  end

  def self.create_table
    sql_table = "CREATE TABLE
    students (id INTEGER PRIMARY KEY,
    name TEXT,
    grade INTEGER);"
    table = DB[:conn].execute(sql_table)
  end

  def self.drop_table
    sql_table = "DROP TABLE students;"
    DB[:conn].execute(sql_table)
    #do i need to store this somewhere?
  end

  def id
    DB[:conn].execute("SELECT students.id FROM students
    ORDER BY students.id
    DESC LIMIT 1;")[0][0]
  end
  #this was super annoying and tricky

  def save
    sql =  "INSERT INTO students(name, grade) VALUES (?,?);"
    DB[:conn].execute(sql, self.name, self.grade)
  end


  def self.create(name:, grade:)
    student = Student.new(name, grade)
    student.save
    return student
  end

end
