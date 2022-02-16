class PartiesController < ApplicationController
  before_action :set_user, only: %i[new create]
  before_action :set_movie, only: [:new]

  def new
    @users = User.all
  end

  def create
    party = Party.create!(party_params)

    params[:invited].each do |invite_user_id|
      party.invites.create!(user_id: invite_user_id)
    end

    redirect_to user_path(@user.id)
  end

  private

  def party_params
    params.permit(:user_id, :movie_id, :start_time, :start_date, :duration)
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def movie_facade
    @movie_facade = MovieFacade.new
  end

  def set_movie
    @movie = movie_facade.find_movie_by_id(params[:movie_id])
  end
end
