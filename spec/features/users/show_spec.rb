require 'rails_helper'

RSpec.describe 'User Dashboard', type: :feature do
  let!(:movie_1) { Movie.new(title: 'Dark Phoenix', id: 13245) }
  let!(:user_1) { User.create!(name: 'Ryan Steve', email: 'rsteve@gmail.com') }
  let!(:party_1) { Party.create!(user_id: user_1.id, movie_id: movie_1.movie_id, start_date: '12-12-2022', start_time: '7:00 pm', duration: 190) }

  let(:user_id) {user_1.id}

  context 'When I visit a user show page' do
    before(:each) do
      visit user_path(user_id)
    end

    scenario "I see <username>'s dashboard" do
      expect(page).to have_content("#{user_1.name}'s Dashboard")
    end

    scenario 'I see a button to discover movies' do
      expect(page).to have_button('Discover Movies')
    end

    scenario 'A section that lists viewing parties' do
      expect(page).to have_content('Viewing Parties')
      expect(page).to have_content(party_1.start_date)
      expect(page).to have_content(party_1.start_time)
    end
  end
end
