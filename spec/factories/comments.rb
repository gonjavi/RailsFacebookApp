# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    content { 'content' }
    association :post, content: 'my content'
    association :user, name: 'mera', email: 'merae5@gmail.com'
  end
end
