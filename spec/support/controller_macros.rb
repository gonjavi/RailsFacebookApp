module ControllerMacros
  def sign_me_in
    before :each do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      @current_user = FactoryBot.create(:user)
      sign_in :user, @current_user
    end
  end
end
