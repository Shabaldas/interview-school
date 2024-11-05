# frozen_string_literal: true

class Enrollment < ApplicationRecord
  belongs_to :student
  belongs_to :section

  validates :student_id, uniqueness: { scope: :section_id }
  validate :no_time_conflict

  private

  def no_time_conflict
    return unless student && section

    student_sections = student.sections
    return if student_sections.empty?

    student_sections.each do |student_section|
      next unless time_conflict?(section, student_section)

      errors.add(:section, 'conflicts with another section')
      break
    end
  end

  def time_conflict?(section1, section2)
    days1 = section1.days_of_week_list.split(', ')
    days2 = section2.days_of_week_list.split(', ')
    days_overlap = days1.intersect?(days2)

    time_overlap = (section1.start_time <= section2.end_time) && (section2.start_time < section1.end_time)
    days_overlap && time_overlap
  end
end
