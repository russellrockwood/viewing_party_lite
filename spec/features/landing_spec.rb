require 'rails_helper'

RSpec.describe 'Landing Page', type: :feature do
  before(:each) do
    visit root_path
  end

  context 'When a user visits the root path' do
    scenario 'they are on the landing page' do
      expect(page).to have_current_path('/')
    end

    scenario 'they see title of application' do
      # set html class and find html later
      expect(page).to have_content('Viewing Party Lite')
    end

    scenario 'they see button to create new user' do
      expect(page).to have_button('Create New User')
    end

    scenario 'they see button to return to landing page' do
      expect(page).to have_link('Home', href: '/')
    end
  end
end
