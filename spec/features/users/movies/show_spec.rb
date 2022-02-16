require 'rails_helper'

RSpec.describe 'Movies Details Page', type: :feature do
  let!(:user_1) { User.create!(name: 'Ryan Steve', email: 'rsteve@gmail.com') }

  let(:user_id) { user_1.id }
  let(:movie_id) { 730_154 }

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

    visit "/users/#{user_id}/results?q=top+rated"

    within "##{movie_id}" do
      click_link 'Your Eyes Tell'
    end
  end

  context 'When I visit a movie details page' do
    scenario 'I see it has the correct url' do
      expect(page).to have_current_path(user_movie_path(user_id, movie_id))
    end

    scenario 'I see it has a button to create a viewing party that takes it to the create page' do
      expect(page).to have_button('Create View Party')
    end

    scenario 'I see it has a button to return to the discover page' do
      expect(page).to have_link('Discover', href: "/users/#{user_id}/discover")
    end

    scenario 'I see details about the movie' do
      facade = MovieFacade.new
      movie = facade.find_movie_by_id(movie_id)
      expect(page).to have_content(movie.title)
      expect(page).to have_content(movie.vote_average)
      expect(page).to have_content(movie.runtime_hour_conversion)

      genres = facade.find_genres(movie.genre_ids)

      genres.each do |genre|
        expect(page).to have_content(genre)
      end

      expect(page).to have_content(movie.summary)

      cast_members = facade.cast_members(movie_id)

      cast_members.first(10).each do |member|
        expect(page).to have_content(member.name)
        expect(page).to have_content(member.character)
      end

      if cast_members.count > 10
        expect(page).to have_no_content(cast_members.last.name)
        expect(page).to have_no_content(cast_members.last.character)
      end
    end

    scenario 'I see it displays review information when there is some' do
      WebMock.allow_net_connect!

      visit "/users/#{user_id}/results?q=top+rated"

      click_link 'Dilwale Dulhania Le Jayenge'

      expect(page).to have_content('MohamedElsharkawy')
    end
  end
end
