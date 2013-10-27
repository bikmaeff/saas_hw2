class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    #@movies = Movie.all
    session[:params] ||= {}
    old = session[:params]

    redirect_to movies_path({param_sort: old[:param_sort], ratings: old[:ratings]}) if (params[:param_sort].blank? && old[:param_sort].present?) || (params[:ratings].blank? && old[:ratings].present?)

    params[:param_sort] = old[:param_sort] if params[:param_sort].nil?
    params[:ratings] = old[:ratings] if params[:ratings].nil?

    session[:params] = {param_sort: params[:param_sort], ratings: params[:ratings]}
    params = session[:params]

    @param_sort = params[:param_sort]
    #@movies = @movies.where(rating: 'R' )
    #@movies = @movies.where(title: "#{params[:id]}")
    #if params[:id] == 'title_header'
    #@movies = Movie.order(@param_sort)
    #elsif params[:id] == 'release_date_header'
    #@movies = Movie.order(@param_sort)
    #end
    @all_ratings = ['G','PG','PG-13','R']
    @ratings = params[:ratings]
    @ratings_arr = @ratings ? @ratings.keys : @all_ratings
    @movies = Movie.where(rating: @ratings_arr).order(@param_sort)
    #session[] =  
  end

  def new
    # default: render 'new' template
    @movie = Movie.new
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
