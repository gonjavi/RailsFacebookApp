# frozen_string_literal: true

class FriendshipController < ApplicationController
  before_action :authenticate_user!, except: %i[show]

  def index
    @friendship = User.all
  end

end
