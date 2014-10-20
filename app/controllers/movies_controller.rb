# This file is app/controllers/movies_controller.rb
class MoviesController < ApplicationController
before_filter :match_filter_uri, only: :index
after_filter :save_filtering_settings, only: :index

  def index
    @movies = Movie.where('rating in (?)', selected_ratings).order(*column_orderings)
    @all_ratings = all_ratings
  end

  def show
  	id = params[:id] # retrieve movie ID from URI route
  	@movie = Movie.find(id) # look up movie by unique ID
  	# will render app/views/movies/show.html.haml by default
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

  private

  def save_filtering_settings
    session[:order] = column_orderings if params.has_key? :order
    session[:ratings] = params[:ratings] if params.has_key? :ratings
  end

  def match_filter_uri
    if (session.has_key?(:order) && params[:order].blank?) ||
      (session.has_key?(:ratings) && params[:ratings].blank?)

      filters = {
        order: params[:order].blank? ? session[:order] : column_orderings,
        ratings: params[:ratings].blank? ? session[:ratings] : params[:ratings]
      }

      redirect_to movies_path(filters)
    end
  end

  def selected_ratings
    if params.has_key?(:ratings)
      params[:ratings].keys
    else
      all_ratings
    end
  end

  def all_ratings
    ['G','PG','PG-13','R','NC-17']
  end

  def column_orderings
    params[:order]
  end
end