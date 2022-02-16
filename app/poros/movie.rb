class Movie
  attr_reader :title,
              :vote_average,
              :movie_id,
              :poster_file_path,
              :summary,
              :genre_ids,
              :runtime,
              :genre_names

  def initialize(data)
    @movie_id = data[:id]
    @title = data[:title].lowercase
    @vote_average = data[:vote_average]
    @poster_file_path = data[:poster_path]
    @summary = data[:overview]
    @genres = data[:genres] || []
    @genre_ids = data[:genre_ids] || set_genre_ids
    @runtime = data[:runtime]
  end

  def runtime_hour_conversion
    hours = @runtime / 60
    rest = @runtime % 60
    time = "#{hours} hours #{rest} minutes"
  end

  def set_genre_ids
    ids = []
    @genres.each do |genre|
      ids << genre[:id]
    end
    ids
  end
end
