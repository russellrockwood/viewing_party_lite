require 'rails_helper'

describe Party, type: :model do
  describe 'validations' do
    it { should validate_presence_of :start_date }
    it { should validate_presence_of :start_time }
    it { should validate_presence_of :duration }
    it { should validate_presence_of :movie_id }
  end

  describe 'relationships' do
    it { should belong_to :user }
    it { should have_many :invites }
  end
end
