class MoviesController < ApplicationController

  before_action :set_movie, only: [:show, :upvote, :downvote]


  def index
    if params[:category].blank? && params[:search].blank?
      @movies = Movie.all.page(params[:page]).per(10)
    elsif params[:search].present?
      search = params[:search]
      movies = Movie.where("title_ru LIKE ? OR title_ru LIKE ? OR lower(title_en) LIKE ?",
        "%#{search.capitalize}%", "%#{search.downcase}%", "%#{search.downcase}%")
      @movies = movies.page(params[:page]).per(10)
    else
      @category = Category.find(params[:category])
      @movies = @category.movies.page(params[:page]).per(10)
    end

    @session = VoterSession.find_by(session_id: request.session_options[:id].to_s)
    if @session == nil
      @session = VoterSession.create(session_id: request.session_options[:id].to_s)
    end

    @categories = Category.all
  end

  def show
    set_rendom_movies
  end

  def upvote
    @session = VoterSession.find_by(session_id: request.session_options[:id].to_s)
    if @session == nil
      @session = VoterSession.create(session_id: request.session_options[:id].to_s)
    end
    @movie.upvote_by @session
      respond_to do |format|
      format.html {redirect_to :back }
      format.json { render json: { count: @movie.liked_count } }
      format.js   { render :layout => false }
    end
  end

  def downvote
    @session = VoterSession.find_by(session_id: request.session_options[:id].to_s)
    if @session == nil
      @session = VoterSession.create(session_id: request.session_options[:id].to_s)
    end
    @movie.downvote_by @session
    respond_to do |format|
      format.html {redirect_to :back }
      format.json { render json: { count: @movie.disliked_count } }
      format.js   { render :layout => false }
    end
  end

  def set_rendom_movies
    @recommendation = []
    i = 0
    r = 0
    7.times do
      if i > @movie.categories.size-1
        i = 0
      end
      random_movie = Movie.find(@movie.categories[i].movies.pluck(:id).sample)
      if @recommendation.include?(random_movie) || (random_movie == @movie)
        if r <= 7
          r += 1
          redo
        else
          break
        end
      else
        @recommendation << random_movie
      end
      i += 1
    end
  end

  private
    def set_movie
      @movie = Movie.find(params[:id])
    end

end
