# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  config.include Devise::Test::ControllerHelpers, type: :controller
end

RSpec.describe FriendshipsController, type: :controller do
  sign_me_in

  before :each do
    @friend = FactoryBot.create(:friend)
  end

  before :each do
    @friendship = FactoryBot.create(:friendship)
  end

  let(:valid_attributes) { { friend_id: @friend.id, user_id: @current_user.id, confirmed: 'false' } }
  let(:invalid_attributes) { { friend_id: nil, user_id: nil } }

  describe 'FRIENDSHIP #' do
    it "renders the index template" do
      get :index
      expect(response).to render_template('index')
    end

    it 'creates a friendship request' do
      expect do
        post :create, params: valid_attributes
      end.to change(Friendship, :count).by(1)
      expect(response).to redirect_to(friendships_path)
      expect(flash[:notice]).to match(/Friendship request sent*/)
    end

    it 'fails to create a friendship request' do
      expect do
        post :create, params: invalid_attributes
      end.to change(Friendship, :count).by(0)
      expect(response).to render_template('posts/index')
      expect(flash[:danger]).to match(/Invalid request*/)
    end

    it 'deletes a friendship' do
      expect do
        delete 'destroy', params: { id: @friendship.id }
      end.to change(Friendship, :count).by(-1)
      expect(response).to redirect_to(friendships_path)
      expect(flash[:notice]).to match(/Friendshid or request was successfully deleted.*/)
    end
  end
end
