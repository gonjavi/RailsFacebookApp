# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  config.include Devise::Test::ControllerHelpers, type: :controller
end

RSpec.describe UsersController, type: :controller do
  sign_me_in

  describe 'GET Users  #show' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end
    
    it 'renders template users show' do
      get :show
      expect(response).to render_template('show')
    end
  end
end
