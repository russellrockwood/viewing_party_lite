require 'rails_helper'

RSpec.describe MovieService do
  let(:service) { MovieService.new }

  before(:each) do
    top_rated_response = File.read('./spec/support/movie_api_responses/top_rated_response.json')

    stub_request(:get, "https://api.themoviedb.org/3/movie/top_rated?api_key=#{ENV['movie_api_key']}&language=en-US&page=1").to_return(body: top_rated_response, status: 200)

    search_fox_response = File.read('./spec/support/movie_api_responses/search_fox_response.json')

    @query = 'Fox'

    stub_request(:get, "https://api.themoviedb.org/3/search/movie?api_key=#{ENV['movie_api_key']}&language=en-US&query=#{@query}&page=1&include_adult=false").to_return(body: search_fox_response, status: 200)
  end

  describe '#top_rated' do
    it 'returns an array of data' do
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
      expect(service.search(@query)).to be_a Array

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
end
