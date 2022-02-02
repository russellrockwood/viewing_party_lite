class MoviesController < ApplicationController
  before_action :movie_facade, only: [:results]

  def discover
    @user = User.find(params[:user_id])
    # @movies = @movie_facade.top_rated_movies
  end

  def results
    if params[:q] == 'top rated'
      @movies = movie_facade.top_rated_movies
    elsif params[:search]
      @movies = movie_facade.search_movies(params[:search])
    end
  end

  private

  def movie_facade
    movie_facade = MovieFacade.new
  end
end
