# frozen_string_literal: true

FactoryBot.define do
  factory :notebook do
    title { Faker::Lorem.sentence(2, false, 0).chomp('.') }
  end
end
