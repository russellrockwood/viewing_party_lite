class LandingController < ApplicationController
  def index; end

  def register
    @user = User.new
  end
end
