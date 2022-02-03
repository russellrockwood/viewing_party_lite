class Movie

  attr_reader :title,
              :vote_average,
              :movie_id,
              :poster_file_path,
              :summary,
              :genres

  def initialize(data)
    @movie_id = data[:id]
    @title = data[:title]
    @vote_average = data[:vote_average]
    @poster_file_path = data[:poster_path]
    @summary = data[:overview]
    @genres = data[:genre_ids]
  end

end
