class UsersController < ApplicationController
  def show
    @fr = User.find(params[:id])
  end

  def index
  end
end
