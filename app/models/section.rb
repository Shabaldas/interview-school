# frozen_string_literal: true

class Section < ApplicationRecord
  belongs_to :teacher
  belongs_to :subject
  belongs_to :classroom

  has_many :enrollments, dependent: :destroy
  has_many :students, through: :enrollments

  validates :start_time, :end_time, :days, presence: true
end
