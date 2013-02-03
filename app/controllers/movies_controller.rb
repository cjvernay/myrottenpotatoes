class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @saved_selections = session[:saved_selections]? session[:saved_selections] : Movie.saved_selections()

    @all_ratings = Movie.all_ratings()
    sort_column = %w[title release_date].
    include?(params[:sort])? params[:sort] : @saved_selections[:sort]
    @saved_selections[:sort] = sort_column

    where_params =  params[:ratings]? params[:ratings] : @saved_selections[:ratings]

    @movies = Movie.order(sort_column).
    where(["rating IN (?)", where_params.keys])
    @saved_selections[:ratings] = where_params

    session[:saved_selections] = @saved_selections

    @th_class = {sort_column => "hilite"}
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
