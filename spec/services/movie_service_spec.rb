require 'rails_helper'

RSpec.describe MovieService, type: :service do
  let(:service) { MovieService.new }

  describe '#top_rated' do
    it 'returns an array of data' do
      top_rated_response = File.read('./spec/support/movie_api_responses/top_rated_response.json')

      stub_request(:get, "https://api.themoviedb.org/3/movie/top_rated?api_key=#{ENV['movie_api_key']}&language=en-US&page=1").to_return(
        body: top_rated_response, status: 200
      )

      expect(service.top_rated).to be_a Array

      service.top_rated.each do |response|
        expect(response).to be_a Hash
        expect(response).to have_key(:id)
        expect(response).to have_key(:title)
        expect(response).to have_key(:vote_average)
        expect(response).to have_key(:poster_path)
        expect(response).to have_key(:overview)
        expect(response).to have_key(:genre_ids)
      end
    end
  end

  describe '#search' do
    it 'returns an array of data' do
      search_fox_response = File.read('./spec/support/movie_api_responses/search_fox_response.json')

      query = 'Fox'

      stub_request(:get, "https://api.themoviedb.org/3/search/movie?api_key=#{ENV['movie_api_key']}&language=en-US&query=#{query}&page=1&include_adult=false").to_return(
        body: search_fox_response, status: 200
      )

      expect(service.search(query)).to be_a Array

      service.search(query).each do |response|
        expect(response).to be_a Hash
        expect(response).to have_key(:id)
        expect(response).to have_key(:title)
        expect(response).to have_key(:vote_average)
        expect(response).to have_key(:poster_path)
        expect(response).to have_key(:overview)
        expect(response).to have_key(:genre_ids)
      end
    end
  end

  describe '#find' do
    it 'returns data for a single movie searched for by id' do
      search_id_response = File.read('./spec/support/movie_api_responses/search_id_730154_response.json')

      movie_id = 730_154

      stub_request(:get, "https://api.themoviedb.org/3/movie/#{movie_id}?api_key=#{ENV['movie_api_key']}&language=en-US").to_return(
        body: search_id_response, status: 200
      )

      expect(service.find(movie_id)).to be_a Hash

      expect(service.find(movie_id)).to have_key(:id)
      expect(service.find(movie_id)).to have_key(:title)
      expect(service.find(movie_id)).to have_key(:vote_average)
      expect(service.find(movie_id)).to have_key(:poster_path)
      expect(service.find(movie_id)).to have_key(:overview)
      expect(service.find(movie_id)).to have_key(:genres)
    end
  end

  describe '#genres' do
    it 'returns a list of genres and their associated ids' do
      genres_response = File.read('./spec/support/movie_api_responses/genres_response.json')

      stub_request(:get, "https://api.themoviedb.org/3/genre/movie/list?api_key=#{ENV['movie_api_key']}&language=en-US").to_return(
        body: genres_response, status: 200
      )

      expect(service.genres).to be_a Array

      service.genres.each do |genre|
        expect(genre).to be_a Hash
        expect(genre).to have_key(:name)
        expect(genre).to have_key(:id)
      end
    end
  end

  describe '#credits' do
    it 'returns the credits for a given movie' do
      credits_response = File.read('./spec/support/movie_api_responses/credits_response.json')

      movie_id = 730_154

      stub_request(:get, "https://api.themoviedb.org/3/movie/#{movie_id}/credits?api_key=#{ENV['movie_api_key']}&language=en-US").to_return(
        body: credits_response, status: 200
      )

      expect(service.credits(movie_id)).to be_a Hash
      expect(service.credits(movie_id)[:cast]).to be_a Array

      service.credits(movie_id)[:cast].each do |cast_member|
        expect(cast_member).to have_key(:name)
        expect(cast_member).to have_key(:character)
      end
    end
  end

  describe '#reviews' do
    it 'returns the reviews for the movie by id' do
      reviews_response = File.read('./spec/support/movie_api_responses/reviews_730154_response.json')

      movie_id = 730_154

      stub_request(:get, "https://api.themoviedb.org/3/movie/#{movie_id}/reviews?api_key=#{ENV['movie_api_key']}&language=en-US&page=1").to_return(
        body: reviews_response, status: 200
      )

      expect(service.reviews(movie_id)).to be_a Hash
      expect(service.reviews(movie_id)[:results]).to be_a Array

      service.reviews(movie_id)[:results].each do |review|
        expect(review).to have_key(:author)
        expect(review).to have_key(:content)
      end
    end
  end
end
