# frozen_string_literal: true

class Teacher < ApplicationRecord
  include Nameable

  has_many :teacher_subjects, dependent: :destroy
  has_many :subjects, through: :teacher_subjects
  accepts_nested_attributes_for :teacher_subjects, allow_destroy: true

  validates :first_name, :last_name, presence: true
end
