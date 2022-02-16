require 'rails_helper'

RSpec.describe 'Movies Results Page', type: :feature do
  let!(:user_1) { User.create!(name: 'Ryan Steve', email: 'rsteve@gmail.com') }
  let(:user_id) { user_1.id }

  before(:each) do
    visit "/users/#{user_id}/discover"
  end

  context 'When I submit a query on the discover page with top rated button' do
    let(:top_rated_response) { File.read('./spec/support/movie_api_responses/top_rated_response.json') }

    before(:each) do
      stub_request(:get, "https://api.themoviedb.org/3/movie/top_rated?api_key=#{ENV['movie_api_key']}&language=en-US&page=1").to_return(
        body: top_rated_response, status: 200
      )

      click_button 'Discover Top Rated Movies'
    end

    scenario 'I am taken to the movie results page' do
      expect(page.status_code).to eq 200
      expect(page).to have_current_path("/users/#{user_id}/results?q=top+rated")
    end

    scenario 'I see the titles of movies are links to their show page' do
      within '#730154' do
        expect(page).to have_link('Your Eyes Tell', href: user_movie_path(user_id, 730_154))
      end
    end

    scenario 'I see the vote average of the movies' do
      within '#730154' do
        expect(page).to have_content('8.8')
      end
    end

    scenario 'I see a link to return to the discover page' do
      expect(page).to have_link('Discover', href: "/users/#{user_id}/discover")
    end
  end

  context 'When I submit a search query on the discover page the firm' do
    let(:search_fox_response) { File.read('./spec/support/movie_api_responses/search_fox_response.json') }
    let(:query) { 'Fox' }

    before(:each) do
      stub_request(:get, "https://api.themoviedb.org/3/search/movie?api_key=#{ENV['movie_api_key']}&language=en-US&query=#{query}&page=1&include_adult=false").to_return(
        body: search_fox_response, status: 200
      )

      fill_in :search, with: 'Fox'
      click_button 'Search'
    end

    scenario 'I am taken to the movie results page' do
      expect(page.status_code).to eq 200
      expect(current_path).to include("/users/#{user_id}/results")
    end

    scenario 'I see the titles of movies are links to their show page' do
      within '#10315' do
        expect(page).to have_link('Fantastic Mr. Fox', href: user_movie_path(user_id, 10_315))
      end
    end

    scenario 'I see the vote avaerage of the movies' do
      within '#10315' do
        expect(page).to have_content('7.7')
      end
    end

    scenario 'I see a link to return to the discover page' do
      expect(page).to have_link('Discover', href: "/users/#{user_id}/discover")
    end
  end
end
