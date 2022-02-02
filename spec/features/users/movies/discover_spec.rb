require 'rails_helper'

RSpec.describe 'Discover Movies Page', type: :feature do
  let!(:user_1) { User.create!(name: 'Ryan Steve', email: 'rsteve@gmail.com') }
  let(:user_id) { user_1.id }

  before(:each) do
    visit "/users/#{user_id}/discover"
  end

  context 'As a user when I click discover movies button on my dashboard' do
    scenario 'I am redirected to discover page for that user' do
      expect(page).to have_current_path("/users/#{user_id}/discover")
    end
  end

  context 'When I visit the discover page' do
    scenario 'I see a button to discover top rated movies' do
      expect(page).to have_button('Discover Top Rated Movies')
    end

    scenario 'I see a text field to search movies and a search button' do
      expect(page).to have_field('search')
      expect(page).to have_button('Search')
    end
  end

  context 'When I visit discover movies page' do
    scenario 'I click on top movies link and am taken to results page' do
      click_button 'Discover Top Rated Movies'
      expect(page.status_code).to eq 200
      expect(current_path).to include("/users/#{user_id}/results")
      expect(page).to have_current_path("/users/#{user_id}/results?q=top+rated")
    end

    scenario 'I fill in the search form and click search and am taken to the results page' do
      fill_in :search, with: 'Fox'
      click_button 'Search'

      expect(page.status_code).to eq 200
      expect(current_path).to include("/users/#{user_id}/results")
    end
  end
end
