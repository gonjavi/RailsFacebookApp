# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'steve' }
    email { 'steve12@steve.com' }
    password { '123456' }
  end
end
