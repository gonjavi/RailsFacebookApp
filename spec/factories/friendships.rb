# frozen_string_literal: true

FactoryBot.define do
  factory :friendship do
    confirmed { false }
    association :user, name: 'jamesito', email: 'jamseito@gmail.com'
    association :friend, name: 'james', email: 'james@gmail.com'
  end
end
