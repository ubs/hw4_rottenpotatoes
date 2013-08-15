require 'spec_helper'

describe Movie do
  describe 'Search for movies with the same director' do

    it 'should invoke method in Movie with director' do
      Movie.should_receive(:similar_directors).with('Aliens')
      Movie.similar_directors('Aliens')
    end

  end
end
