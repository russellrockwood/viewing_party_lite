class MoviesController < ApplicationController
  before_action :movie_facade, only: [:results]
  before_action :set_user, only: [:discover, :results]

  def discover
    # @user = User.find(params[:user_id])
    # @movies = @movie_facade.top_rated_movies
  end

  def results
    # @user = User.find(params[:user_id])

    if params[:q] == 'top rated'
      @movies = movie_facade.top_rated_movies
    elsif params[:search]
      @movies = movie_facade.search_movies(params[:search])
    end
  end

  def show
  end

  private

  def movie_facade
    movie_facade = MovieFacade.new
  end

  def set_user
    @user = User.find(params[:user_id])
  end
end
