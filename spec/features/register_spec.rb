require 'rails_helper'

RSpec.describe 'Register Page', type: :feature do
  before(:each) do
    visit '/register'
  end

  context 'When a user visits the register path' do
    scenario 'they are on the registration page' do
      expect(page).to have_current_path('/register')
    end

    scenario 'they see a name input field' do
      expect(page).to have_field('Name')
    end

    scenario 'they see an email input field' do
      expect(page).to have_field('Email')
    end

    scenario 'they see button to register new user' do
      expect(page).to have_button('Register')
    end

    scenario 'they are redirected to user dashboard upon succesful registration' do
      fill_in 'Name', with: 'Lord Russell'
      fill_in 'Email', with: 'Russell@gmail.com'
      click_button 'Register'

      expect(page).to have_content("Lord Russell's Dashboard")
    end

    scenario 'they are redirected back to registration view if registration fails' do
      fill_in 'Name', with: ''
      fill_in 'Email', with: ''
      click_button 'Register'

      expect(current_path).to eq('/register')
      expect(page).to have_content('User Not Created: Required info missing.')
    end

    scenario 'they are redirected back to registration view if email is already taken' do
      User.create!(name: 'Bob', email: 'russell@gmail.com')
      fill_in 'Name', with: 'Russell'
      fill_in 'Email', with: 'russell@gmail.com'
      click_button 'Register'

      expect(current_path).to eq('/register')
      expect(page).to have_content('User Not Created: Email Taken.')
    end
  end
end
