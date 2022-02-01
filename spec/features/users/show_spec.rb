require 'rails_helper'

RSepc.describe 'User Dashboard', type: :feature do
  let!(:movie_1) { Movie.create!(title: 'Dark Phoenix')}
  let!(:user_1) { User.create!(name: 'Ryan Steve', 'rsteve@gmail.com')}
  let!(:view_party_1) { ViewParty.create!(user_id: user_1.id, movie_id: movie_1.id)}

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
    end
  end
end
