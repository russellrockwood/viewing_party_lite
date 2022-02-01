class UsersController < ApplicationController

  def create
    user = User.new(user_params)
    if user.save
      redirect_to user_path(user.id)
    else
      flash[:notice] = 'User Not Created: Required info missing.'
      render :template => 'landing/register'
    end
  end

  def show

  end

  private
  def user_params
    params.require(:user).permit(:name, :email)
  end

end
