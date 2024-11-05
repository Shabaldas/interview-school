require 'faker'

puts "Clearing existing data..."
Enrollment.delete_all
Student.delete_all
Section.delete_all
Classroom.delete_all
TeacherSubject.delete_all
Teacher.delete_all
Subject.delete_all

puts "Creating Classrooms..."
classrooms = []
5.times do
  classrooms << Classroom.create!(name: "Room #{Faker::Number.unique.number(digits: 3)}")
end

puts "Creating Subjects..."
subjects = []
10.times do
  subjects << Subject.create!(name: Faker::Educator.unique.course_name)
end

puts "Creating Teachers..."
teachers = []
10.times do
  teacher = Teacher.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name
  )
  teachers << teacher
end

puts "Assigning Teachers to Subjects..."
teachers.each do |teacher|
  assigned_subjects = subjects.sample(3)
  assigned_subjects.each do |subject|
    TeacherSubject.create!(teacher: teacher, subject: subject)
  end
end

puts "Creating Sections..."
days_options = [
  ["Monday", "Wednesday", "Friday"],
  ["Tuesday", "Thursday"],
  ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
]
start_times = [Time.parse("7:30 AM"), Time.parse("8:30 AM"), Time.parse("9:30 AM"), Time.parse("10:30 AM"), Time.parse("1:00 PM"), Time.parse("2:00 PM"), Time.parse("3:00 PM"), Time.parse("4:00 PM")]
durations = [50.minutes, 80.minutes]

sections = []
subjects.each do |subject|
  qualified_teachers = subject.teachers
  next if qualified_teachers.empty?

  3.times do
    teacher = qualified_teachers.sample
    classroom = classrooms.sample
    days = days_options.sample
    start_time = start_times.sample
    duration = durations.sample
    end_time = start_time + duration

    sections << Section.create!(
      subject: subject,
      teacher: teacher,
      classroom: classroom,
      start_time: start_time,
      end_time: end_time,
      days: days.to_json
    )
  end
end

puts "Creating Students..."
students = []
5.times do
  students << Student.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name
  )
end

def sections_conflict?(section1, section2)
  days1 = JSON.parse(section1.days)
  days2 = JSON.parse(section2.days)
  days_overlap = (days1 & days2).any?

  time_overlap = (section1.start_time < section2.end_time) && (section2.start_time < section1.end_time)
  days_overlap && time_overlap
end

puts "Enrolling Students in Sections..."
students.each do |student|
  available_sections = sections.shuffle
  student_sections = []

  available_sections.each do |section|
    conflict = student_sections.any? do |enrolled_section|
      sections_conflict?(section, enrolled_section)
    end

    unless conflict
      Enrollment.create!(student: student, section: section)
      student_sections << section
    end
  end
end

puts "Seeding completed successfully."
