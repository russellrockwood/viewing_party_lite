require 'rails_helper'

RSpec.describe Movie do
  let(:movie) { Movie.new(title: 'Dark Phoenix', vote_average: '8.8', id: '12345', poster_path: '/users/path', overview: 'This is a summary', genre_ids: [1, 2, 3]) }

  it 'exists' do
    expect(movie).to be_instance_of Movie
  end

  it 'has attributes' do
    expect(movie.title).to eq 'Dark Phoenix'
    expect(movie.vote_average).to eq '8.8'
    # expect(movie.movie_id).to eq '12345'
    expect(movie.poster_file_path).to eq '/users/path'
    expect(movie.summary).to eq 'This is a summary'
    expect(movie.genres).to eq [1, 2, 3]
  end
end
