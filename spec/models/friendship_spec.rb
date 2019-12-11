# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Friendship, type: :model do
  it 'validates empty user_id' do
    friendship = FactoryBot.build(:friendship, user_id: '')
    friendship.valid?
  end

  it 'validates empty friend_id' do
    friendship = FactoryBot.build(:friendship, friend_id: '')
    friendship.valid?
  end
end
