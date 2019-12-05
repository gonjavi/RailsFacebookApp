# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  config.include Devise::Test::ControllerHelpers, type: :controller
end

RSpec.describe CommentsController, type: :controller do
  sign_me_in
  before :each do
    @comment = create(:comment)
  end

  let(:valid_attributes) { { content: 'comment', user_id: @current_user.id, post_id: @comment.post.id } }
  let(:invalid_attributes) { { content: '', user_id: nil } }

  describe 'Comment #' do
    it 'creates a new Comment' do
      expect do
        post :create, params: { comment: valid_attributes }
      end.to change(Comment, :count).by(1)
      expect(response).to redirect_to(posts_path)
      expect(flash[:notice]).to match(/Comment was successfully created.*/)
    end

    it 'fails to create a new Comment' do
      expect do
        post :create, params: { comment: invalid_attributes }
      end.to change(Comment, :count).by(0)
      expect(response).to render_template('new')
      expect { Comment.new.foo }.to raise_error(NameError)
    end

    it 'updates a Comment' do
      expect do
        put 'update', params: { 
          id: @comment.id, comment: { content: 'update', user_id: @current_user.id, post_id: @comment.post.id } }
      end.to change(Post, :count).by(0)
      expect(response).to redirect_to(posts_path)
      expect(flash[:notice]).to match(/Comment was successfully updated.*/)
    end

    it 'fails updating a Post' do
      expect do
        put 'update', params: { id: @comment.id, comment: { content: '', user_id: nil } }
      end.to change(Post, :count).by(0)
      expect(response).to render_template('edit')
      expect { Comment.new.foo }.to raise_error(NameError)
    end

    it 'deletes a comment' do
      expect do
        delete 'destroy', params: { id: @comment.id }
      end.to change(Comment, :count).by(-1)
      expect(response).to redirect_to(posts_path)
      expect(flash[:notice]).to match(/Comment was successfully deleted.*/)
    end
  end
end
