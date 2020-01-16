# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Like, type: :model do
  it 'validates empty user_id' do
    like = FactoryBot.build(:like, user_id: '')
    like.valid?
    expect(like.errors[:user_id]).to include("can't be blank")
  end
end
