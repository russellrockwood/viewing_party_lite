require 'rails_helper'

RSpec.describe CastMember do
  let(:member) { CastMember.new(name: 'Ryan Stiles', character: 'Robby Stylin') }
  it 'exists' do
    expect(member).to be_instance_of CastMember
  end

  it 'has attributes' do
    expect(member.name).to eq('Ryan Stiles')
    expect(member.character).to eq('Robby Stylin')
  end
end
