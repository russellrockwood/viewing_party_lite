class MovieService
  def get_url(url)
    Faraday.new(url)
  end

  def top_rated
    conn = get_url('https://api.themoviedb.org')

    response = conn.get("/3/movie/top_rated?api_key=#{ENV['movie_api_key']}&language=en-US&page=1")

    JSON.parse(response.body, symbolize_names: true)[:results]
  end

  def search(query)
    conn = get_url('https://api.themoviedb.org')

    response = conn.get("/3/search/movie?api_key=#{ENV['movie_api_key']}&language=en-US&query=#{query}&page=1&include_adult=false")

    data = JSON.parse(response.body, symbolize_names: true)

    data[:results]
  end

  def find(movie_id)
    conn = get_url('https://api.themoviedb.org')

    response = conn.get("/3/movie/#{movie_id}?api_key=#{ENV['movie_api_key']}&language=en-US")

    data = JSON.parse(response.body, symbolize_names: true)
  end

  def genres
    conn = get_url('https://api.themoviedb.org')

    response = conn.get("/3/genre/movie/list?api_key=#{ENV['movie_api_key']}&language=en-US")

    data = JSON.parse(response.body, symbolize_names: true)

    data[:genres]
  end

  def credits(movie_id)
    conn = get_url('https://api.themoviedb.org')

    response = conn.get("/3/movie/#{movie_id}/credits?api_key=#{ENV['movie_api_key']}&language=en-US")

    data = JSON.parse(response.body, symbolize_names: true)
  end

  def reviews(movie_id)
    conn = get_url('https://api.themoviedb.org')

    response = conn.get("/3/movie/#{movie_id}/reviews?api_key=#{ENV['movie_api_key']}&language=en-US&page=1")

    data = JSON.parse(response.body, symbolize_names: true)
  end
end
