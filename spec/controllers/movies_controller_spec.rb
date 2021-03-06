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

    it 'should generate correct routing for similar movie director' do
      { :get => movie_similar_path("1") }.should 
	route_to(:controller => "movies", :action => "similar", :movie_id => "1")
    end

    it 'should invoke the find method to find the movie details' do
      Movie.should_receive(:find).with('1').and_return(@mock_movie)
      get :similar, :movie_id => '1'
    end

    it 'should invoke the find movies with similar directors method' do
      Movie.should_receive(:similar_directors).with('director').and_return(nil)
      get :similar, :movie_id => '1'
    end

    it 'should select the similar template for rendering' do
      get :similar, :movie_id => '1'
      response.should render_template('similar')
    end

    it 'should make the movies available to the view' do
      mock_movies = [mock(Movie), mock(Movie), mock(Movie)]
      Movie.stub(:similar_directors).with('director').and_return(mock_movies)
      get :similar, :movie_id => '1'
      assigns(:movies).should eq mock_movies
    end
  end

  describe 'Movies With Same Director Sad Path' do
    before :each do
      @mock_movie = mock(Movie, :title => "Mooc Armando Movie", :director => nil, :id => "1")
      Movie.stub!(:find).with("1").and_return(@mock_movie)
    end

    it 'should redirect to the movies page' do
      get :similar, :movie_id => "1"
      response.should redirect_to(movies_path)
    end
	
    it 'should populate a flash message for the view' do
      get :similar, :movie_id => "1"
      flash[:notice].should_not be_blank
    end
  end

end
