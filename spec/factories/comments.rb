# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    content { 'content' }
    user { nil }
    post { nil }
  end
end
