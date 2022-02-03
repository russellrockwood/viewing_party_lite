class Movie

  attr_reader :title,
              :vote_average,
              :movie_id

  def initialize(data)
    @movie_id = data[:id]
    @title = data[:title]
    @vote_average = data[:vote_average]
    # @run_time = 0
    @poster_file_path = data[:poster_path]
    @summary = data[:overview]
    @genres = data[:genre_ids]
  end

end
