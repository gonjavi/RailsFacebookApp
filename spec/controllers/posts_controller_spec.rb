# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  config.include Devise::Test::ControllerHelpers, type: :controller
end

RSpec.describe PostsController, type: :controller do
  sign_me_in
  let(:valid_attributes) { { content: 'new post', user_id: @current_user.id } }
  let(:invalid_attributes) { { content: '', user_id: nil } }

  before :each do
    @post = FactoryBot.create(:post)
  end

  describe 'POST #' do
    it 'creates a new Post' do
      expect do
        post :create, params: { post: valid_attributes }
      end.to change(Post, :count).by(1)
      expect(response).to redirect_to(posts_path)
      expect(flash[:notice]).to match(/Post was successfully created.*/)
    end

    it 'fails to create a new Post' do
      expect do
        post :create, params: { post: invalid_attributes }
      end.to change(Post, :count).by(0)
      expect(response).to render_template('new')
      expect { Post.new.foo }.to raise_error(NameError)
    end

    it 'updates a Post' do
      expect do
        put 'update', params: { id: @post.id, post: { content: 'update  content', user_id: @current_user.id } }
      end.to change(Post, :count).by(0)
      expect(response).to redirect_to(posts_path)
      expect(flash[:notice]).to match(/Post was successfully updated.*/)
    end

    it 'fails updating a Post' do
      expect do
        put 'update', params: { id: @post.id, post: { content: '', user_id: nil } }
      end.to change(Post, :count).by(0)
      expect(response).to render_template('edit')
      expect { Post.new.foo }.to raise_error(NameError)
    end

    it 'deletes a post' do
      expect do
        delete 'destroy', params: { id: @post.id }
      end.to change(Post, :count).by(-1)
      expect(response).to redirect_to(posts_path)
      expect(flash[:notice]).to match(/Post was successfully deleted.*/)
    end
  end
end
