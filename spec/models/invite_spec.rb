require 'rails_helper'

describe Invite, type: :model do
  describe 'validations' do
    it { should validate_presence_of :user_id}
    it { should validate_presence_of :party_id}
  end

  describe 'relationships' do
    it { should belong_to :party }
  end
end
