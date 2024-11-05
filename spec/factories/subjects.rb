# frozen_string_literal: true

FactoryBot.define do
  factory :subject do
    name { Faker::Educator.subject }
  end
end
