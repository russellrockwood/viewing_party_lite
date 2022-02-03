require 'rails_helper'

describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :email }
  end

  describe 'relationships' do
    it { should have_many :parties }
    it { should have_many(:invites).through(:parties) }
  end
end
