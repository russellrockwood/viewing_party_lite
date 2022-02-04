class MoviesController < ApplicationController
  before_action :movie_facade, only: [:results, :show]
  before_action :set_user, only: [:discover, :results, :show]

  def discover;  end

  def results
    if params[:q] == 'top rated'
      @movies = movie_facade.top_rated_movies
    elsif params[:search]
      @movies = movie_facade.search_movies(params[:search])
    end
  end

  def show
    @movie = movie_facade.find_movie_by_id(params[:id])
  end

  private

  def movie_facade
    @movie_facade = MovieFacade.new
  end

  def set_user
    @user = User.find(params[:user_id])
  end
end
