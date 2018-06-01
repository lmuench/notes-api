# frozen_string_literal: true

FactoryBot.define do
  factory :note do
    subject { Faker::Lorem.sentence(2, false, 0).chomp('.') }
    content { Faker::Lorem.paragraph }
  end
end
