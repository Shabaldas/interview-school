# frozen_string_literal: true

FactoryBot.define do
  factory :section do
    teacher
    subject
    classroom
    start_time { Faker::Time.between_dates(from: Time.zone.today.beginning_of_day + 7.hours, to: Time.zone.today.beginning_of_day + 20.hours, period: :day) }
    end_time   { start_time + [50.minutes, 80.minutes].sample }
    days       { ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'].sample(rand(1..5)).sort }
  end
end
