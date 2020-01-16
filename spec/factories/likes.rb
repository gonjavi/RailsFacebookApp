# frozen_string_literal: true

FactoryBot.define do
  factory :like do
    association :user, name: 'james', email: 'javireir@gmail.com'
    association :post
  end
end
