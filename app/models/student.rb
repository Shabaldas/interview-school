# frozen_string_literal: true

class Student < ApplicationRecord
  include Nameable

  has_many :enrollments, dependent: :destroy
  has_many :sections, through: :enrollments

  validates :first_name, :last_name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end
