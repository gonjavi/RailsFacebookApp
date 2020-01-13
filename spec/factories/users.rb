# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'steve' }
    email { 'steve12@steven.com' }
    password { '123456' }
  end

  factory :friend, class: User do
    name { 'steve' }
    email { 'steve12343@steven.com' }
    password { '123456' }
  end
end
