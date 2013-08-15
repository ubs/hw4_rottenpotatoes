require 'spec_helper'

describe MoviesController do
  describe 'Add movie director' do
    before :each do
      @mock_movie = mock(Movie, :title => "Star Wars", :director => "director", :id => "1")

      Movie.stub!(:find).with("1").and_return(@mock_movie)
      @mock_movie.stub!(:update_attributes!).and_return(true)
    end

    it 'should call update_attributes on movie object' do
      put :update, {:id => "1", :movie => @mock_movie}
    end

    it 'should redirect to details page with a flash message' do
      put :update, {:id => "1", :movie => @mock_movie}
      response.should redirect_to(movie_path(@mock_movie))
      flash[:notice].should_not be_blank
    end

    it 'should make the director available to the view' do
      put :update, {:id => "1", :movie => @mock_movie}
      assigns(:movie).should eq @mock_movie
      assigns(:movie).director.should eq @mock_movie.director
    end
  end

  describe 'Movies With Same Director Happy Path' do
    before :each do
      @mock_movie = mock(Movie, :title => "Star Wars", :director => "director", :id => "1")

      Movie.stub!(:find).with("1").and_return(@mock_movie)
    end

    it 'should generating routing for similar movie director' do
      pending 'Placeholder'
    end
  end

  describe 'Movies With Same Director Sad Path' do
    it 'should return to the movies page' do
      pending 'Placeholder'
    end
  end
end
