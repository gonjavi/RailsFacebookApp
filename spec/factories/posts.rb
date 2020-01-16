# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    content { 'my Event' }
    association :user, name: 'james', email: 'javirer@gmail.com'
  end
end
