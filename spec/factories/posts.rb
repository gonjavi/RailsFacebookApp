# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    content { 'my Event' }
    user {}
  end
end
