class MovieFacade
  attr_reader :service

  def initialize
    @service = start_service
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

  def find_movie_by_id(movie_id)
    @movie = Movie.new(service.find(movie_id))
  end

  def find_genres(genre_ids)
    genre_name = []
    genre_ids.each do |genre_id|
      service.genres.each do |genre|
        if genre[:id] == genre_id
          genre_name << genre[:name]
        end
      end
    end
    genre_name
  end

  def cast_members(movie_id)
    cast = service.credits(movie_id)[:cast].map do |data|
      CastMember.new(data)
    end
  end

  def reviews(movie_id)
    reviews = service.reviews(movie_id)[:results].each do |data|
      Review.new(data)
    end
  end

  def start_service
    @service = MovieService.new
  end
end
