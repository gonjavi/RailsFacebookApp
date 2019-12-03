# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  config.include Devise::Test::ControllerHelpers, type: :controller
end

RSpec.describe LikesController, type: :controller do
  sign_me_in
  let(:valid_attributes) { { id: 1, user_id: @current_user.id, post_id: 1 } }
  let(:valid_attributes1) { { id: 1, user_id: @current_user.id, post_id: 1, comment_id: 1 } }

  describe 'Like #create' do
    context 'with valid params' do
      it 'creates a new Like for a post' do
        expect do
          post :create, params: { post: valid_attributes }
        end.to change(Like, :count).by(1)
      end

      it 'creates a new Like for a comment' do
        expect do
          post :create, params: { post: valid_attributes1 }
        end.to change(Like, :count).by(1)
      end
    end
  end
end
