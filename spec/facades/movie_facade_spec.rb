require 'rails_helper'

RSpec.describe MovieFacade do
  let(:facade) { MovieFacade.new}

  before(:each) do
    top_rated_response = File.read('./spec/support/movie_api_responses/top_rated_response.json')

    stub_request(:get, "https://api.themoviedb.org/3/movie/top_rated?api_key=#{ENV['movie_api_key']}&language=en-US&page=1").to_return(body: top_rated_response, status: 200)

    search_fox_response = File.read('./spec/support/movie_api_responses/search_fox_response.json')

    @query = 'Fox'

    stub_request(:get, "https://api.themoviedb.org/3/search/movie?api_key=#{ENV['movie_api_key']}&language=en-US&query=#{@query}&page=1&include_adult=false").to_return(body: search_fox_response, status: 200)
  end

  it 'initializes with a service' do
    expect(facade.service).to be_instance_of MovieService
  end

  describe '#top_rated_movies' do
    it 'returns an array of movie objects' do
      expect(facade.top_rated_movies).to be_a Array

      facade.top_rated_movies.each do |movie|
        expect(movie).to be_a Movie
      end

      expect(facade.top_rated_movies.count < 40).to be true
    end
  end

  describe '#search_movies' do
    it 'returns an array of movei objects' do
      expect(facade.search_movies(@query)).to be_a Array

      facade.search_movies(@query).each do |movie|
        expect(movie).to be_a Movie
        expect(movie.title).to include('Fox')
      end

      expect(facade.search_movies(@query).count < 40).to be true
    end
  end
end
