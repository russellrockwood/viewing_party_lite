require 'rails_helper'

RSpec.describe 'Discover Movies Page', type: :feature do
  let!(:user_1) { User.create!(name: 'Ryan Steve', email: 'rsteve@gmail.com') }
  let(:user_id) { user_1.id }
  context 'As a user when I click discover movies button on my dashboard' do
    scenario 'I am redirected to discover page for that user' do
      visit "/users/#{user_id}/discover"

      expect(page).to have_current_path("/users/#{user_id}/discover")
    end
  end
end
