# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  config.include Devise::Test::ControllerHelpers, type: :controller
end

RSpec.describe CommentsController, type: :controller do
  sign_me_in
  @post = FactoryBot.build(:post)
  let(:comment_params) { { id: 1, content: ' a comment', user_id: @current_user.id, post_id:1 } }

  describe 'Comment #create' do
    context 'with valid params' do
      it 'creates a new Comment to a post' do
        expect do
          post :create, params: { post: comment_params }
        end.to change(Comment, :count).by(1)
      end
    end
  end
end
