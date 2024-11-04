# frozen_string_literal: true

class TeacherSubject < ApplicationRecord
  DEFAULT_LEVEL = 5

  belongs_to :teacher
  belongs_to :subject

  validates :teacher, uniqueness: { scope: :subject }, if: :_not_marked_for_destruction?

  validates :level, presence: true
  before_validation :_default_values_on_create, on: :create

  def _default_values_on_create
    self.level ||= DEFAULT_LEVEL

    true
  end

  def _not_marked_for_destruction?
    subject.teacher_subjects.none?(&:_destroy)
  end
end
