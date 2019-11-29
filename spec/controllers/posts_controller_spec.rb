# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  config.include Devise::Test::ControllerHelpers, type: :controller
end

RSpec.describe PostsController, type: :controller do
  sign_me_in
  let(:valid_attributes) { { id: 1, content: 'updated_first_name', user_id: @current_user.id } }

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Post' do
        expect do
          post :create, params: { post: valid_attributes }
        end.to change(Post, :count).by(1)
      end
    end
  end
end
