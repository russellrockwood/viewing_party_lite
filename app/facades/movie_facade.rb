class MovieFacade
  attr_reader :service

  def initialize
    @service = service
  end

  def top_rated_movies
    @movies = service.top_rated.map do |data|
      Movie.new(data)
    end
  end

  def search_movies(query)
    @movies = service.search(query).map do |data|
      Movie.new(data)
    end
  end

  def service
    @service = MovieService.new
  end
end