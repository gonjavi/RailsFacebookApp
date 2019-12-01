# frozen_string_literal: true

RSpec.describe Post, type: :model do
  it 'validates empty post' do
    post = FactoryBot.build(:post, content: nil)
    post.valid?
    expect(post.errors[:content]).to include("can't be blank")
  end
end
