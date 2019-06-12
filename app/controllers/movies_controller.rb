class MoviesController < ApplicationController
  before_action :set_movie, only: [:show]

  def index
    if params[:category].blank?
      @movies = Movie.all.page(params[:page]).per(20)
    else
      @category = Category.find(params[:category])
      @movies = @category.movies.page(params[:page]).per(20)
    end

    @categories = Category.all
  end

  def show

  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def movie_params
      params.fetch(:movie, {})
    end
end
