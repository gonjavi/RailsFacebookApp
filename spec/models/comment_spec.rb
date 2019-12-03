# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  it 'validates empty Comment' do
    comment = FactoryBot.build(:comment, content: nil)
    comment.valid?
    expect(comment.errors[:content]).to include("can't be blank")
  end

  it 'validates empty user_id' do
    comment = FactoryBot.build(:comment, user_id: '')
    comment.valid?
    expect(comment.errors[:user_id]).to include("can't be blank")
  end

  it 'validates empty post_id' do
    comment = FactoryBot.build(:comment, post_id: '')
    comment.valid?
    expect(comment.errors[:post_id]).to include("can't be blank")
  end
end
