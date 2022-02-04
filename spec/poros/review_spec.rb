require 'rails_helper'

RSpec.describe Review do
  let(:review) { Review.new(author: 'Skillywiggles', content: 'I liked this movie')}

  it 'exists' do
    expect(review).to be_instance_of Review
  end

  it 'has attributes' do
    expect(review.author).to eq('Skillywiggles')
    expect(review.content).to eq('I liked this movie')
  end
end
