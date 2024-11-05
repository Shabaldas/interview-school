# frozen_string_literal: true

FactoryBot.define do
  factory :teacher_subject do
    teacher
    subject
    level { rand(1..10) }
  end
end
