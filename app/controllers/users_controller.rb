class UsersController < ApplicationController
  def create
    user = User.new(user_params)

    if User.find_by(email: params[:user][:email]) != nil
      flash[:notice] = 'User Not Created: Email Taken.'
      redirect_to '/register'
    elsif user.save
      redirect_to user_path(user.id)
    else
      flash[:notice] = 'User Not Created: Required info missing.'
      redirect_to '/register'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
