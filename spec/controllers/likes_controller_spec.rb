# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  config.include Devise::Test::ControllerHelpers, type: :controller
end

RSpec.describe LikesController, type: :controller do
  sign_me_in
  before :each do
    @like = build(:like)
  end

  let(:valid_attributespost) { { user_id: @current_user.id, post_id: @like.post.id } }
  let(:invalid_attributespost) { { user_id: nil, post_id: nil } }
  let(:invalid_attributescomment) { { user_id: nil, post_id: nil } }

  describe 'Like #' do
    it 'creates a new Like for a post' do
      expect do
        post :create, params: { like: valid_attributespost }
      end.to change(Like, :count).by(1)
      expect(response).to redirect_to(posts_path)
    end

    it 'fails to create a new Like for a post' do
      expect do
        post :create, params: { like: invalid_attributescomment }
      end.to change(Comment, :count).by(0)
    end

    it 'fails to create a new Like for a comment' do
      expect do
        post :create, params: { like: invalid_attributespost }
      end.to change(Comment, :count).by(0)
    end

    it 'deletes a like' do
      @like1 = create(:like)
      expect do
        delete 'destroy', params: { id: @like1.id }
      end.to change(Like, :count).by(-1)
      expect(response).to redirect_to(posts_path)
    end
  end
end
