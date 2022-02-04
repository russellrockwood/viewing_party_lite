require 'rails_helper'

RSpec.describe 'Parties Create Page', type: :feature do
  let!(:user_1) { User.create!(name: 'Ryan Steve', email: 'rsteve@gmail.com') }
  let!(:user_2) { User.create!(name: 'Blake Michaels', email: 'rstwvwbfre@gmail.com') }
  let!(:user_3) { User.create!(name: 'Marcy Elliot', email: 'mcel@gmail.com') }

  let(:user_id) { user_1.id }
  let(:movie_id) { 730154 }

  before(:each) do
    visit "/users/#{user_id}/results?q=top+rated"

    within "##{movie_id}" do
      click_link 'Your Eyes Tell'
    end

    click_button 'Create View Party'
  end

  describe 'When I visit a new view party page' do
    scenario 'I should see I am at the right path' do
      expect(page).to have_current_path(new_user_movie_party_path(user_id, movie_id))
    end

    scenario 'I should see the title of the movie above a form' do
      title = find('#title')
      form = find('#form')

      expect(title).to appear_before(form)
    end

    scenario 'I see the form has fields' do
      within '#form' do
        expect(page).to have_field('Duration', with: '123')
        expect(page).to have_field(:start_date)
        expect(page).to have_field(:start_time)
        expect(page).to have_field('invited[]')
        expect(page).to have_button('Create Party')
      end
    end

    scenario 'There should be checkboxes next to each existing user in the system for invites'
    scenario 'Submitting the form redirects me to the user dashboard where I see the view party'
    scenario 'I can see the event displayed on other user dashboards who were invited to the party'
  end

#
#  Duration of Party with a default value of movie runtime in minutes; a viewing party should NOT be created if set to a value less than the duration of the movie
#  When: field to select date
#  Start Time: field to select time
#  Checkboxes next to each existing user in the system
#  Button to create a party
# Details When the party is created, the user should be redirected back to the dashboard where the new event is shown. The event should also be listed on any other user's dashbaords that were also invited to the party.
end
