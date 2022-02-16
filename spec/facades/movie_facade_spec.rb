require 'rails_helper'

RSpec.describe MovieFacade, type: :facade do
  let(:facade) { MovieFacade.new }

  before(:each) do
    top_rated_response = File.read('./spec/support/movie_api_responses/top_rated_response.json')

    stub_request(:get, "https://api.themoviedb.org/3/movie/top_rated?api_key=#{ENV['movie_api_key']}&language=en-US&page=1").to_return(
      body: top_rated_response, status: 200
    )

    search_fox_response = File.read('./spec/support/movie_api_responses/search_fox_response.json')

    @query = 'Fox'

    stub_request(:get, "https://api.themoviedb.org/3/search/movie?api_key=#{ENV['movie_api_key']}&language=en-US&query=#{@query}&page=1&include_adult=false").to_return(
      body: search_fox_response, status: 200
    )

    search_id_response = File.read('./spec/support/movie_api_responses/search_id_730154_response.json')

    @movie_id = 730_154

    stub_request(:get, "https://api.themoviedb.org/3/movie/#{@movie_id}?api_key=#{ENV['movie_api_key']}&language=en-US").to_return(
      body: search_id_response, status: 200
    )

    genres_response = File.read('./spec/support/movie_api_responses/genres_response.json')

    stub_request(:get, "https://api.themoviedb.org/3/genre/movie/list?api_key=#{ENV['movie_api_key']}&language=en-US").to_return(
      body: genres_response, status: 200
    )

    credits_response = File.read('./spec/support/movie_api_responses/credits_response.json')

    stub_request(:get, "https://api.themoviedb.org/3/movie/#{@movie_id}/credits?api_key=#{ENV['movie_api_key']}&language=en-US").to_return(
      body: credits_response, status: 200
    )

    reviews_response = File.read('./spec/support/movie_api_responses/reviews_730154_response.json')

    stub_request(:get, "https://api.themoviedb.org/3/movie/#{@movie_id}/reviews?api_key=#{ENV['movie_api_key']}&language=en-US&page=1").to_return(
      body: reviews_response, status: 200
    )

    reviews_response_2 = File.read('./spec/support/movie_api_responses/reviews_19404_response.json')

    stub_request(:get, "https://api.themoviedb.org/3/movie/19404/reviews?api_key=#{ENV['movie_api_key']}&language=en-US&page=1").to_return(
      body: reviews_response_2, status: 200
    )
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

  describe '#find_movie_by_id' do
    it 'returns a single movie object with the searched id' do
      expect(facade.find_movie_by_id(@movie_id)).to be_a Movie
      expect(facade.find_movie_by_id(@movie_id).movie_id).to eq @movie_id
    end
  end

  describe '#find_genre' do
    it 'returns a single genre based on the id' do
      expect(facade.find_genres([28, 12])).to be_a Array
      expect(facade.find_genres([28, 12])).to include('Action')
      expect(facade.find_genres([28, 12])).to include('Adventure')
    end
  end

  describe '#cast_members' do
    it 'returns an array of cast member objects' do
      expect(facade.cast_members(@movie_id)).to be_a Array

      facade.cast_members(@movie_id).each do |member|
        expect(member).to be_instance_of CastMember
      end
    end
  end

  describe '#reviews' do
    it 'returns reviews for movie based on movie id' do
      expect(facade.reviews(@movie_id)).to be_a Array
      expect(facade.reviews(@movie_id).first).to eq(nil)

      expect(facade.reviews(19_404)).to be_a Array

      facade.reviews(19_404).each do |review|
        expect(review).to have_key(:author)
        expect(review).to have_key(:content)
      end
    end
  end
end
