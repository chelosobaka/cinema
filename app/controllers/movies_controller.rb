class MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :upvote, :downvote]

  def index
    if params[:category].blank?
      @movies = Movie.all.page(params[:page]).per(10)
    else
      @category = Category.find(params[:category])
      @movies = @category.movies.page(params[:page]).per(10)
    end

    @categories = Category.all
  end

  def show

  end

  def upvote
    @session = VoterSession.find_by(session_id: request.session_options[:id])
    if @session == nil
      @session = VoterSession.create(session_id: request.session_options[:id])
    end
    @movie.upvote_by @session
      respond_to do |format|
      format.html {redirect_to :back }
      format.json { render json: { count: @movie.liked_count } }
      format.js   { render :layout => false }
    end
  end

  def downvote
    @session = VoterSession.find_by(session_id: request.session_options[:id])
    if @session == nil
      @session = VoterSession.create(session_id: request.session_options[:id])
    end
    @movie.downvote_by @session
      respond_to do |format|
        format.html {redirect_to :back }
        format.json { render json: { count: @movie.disliked_count } }
        format.js   { render :layout => false }
      end
  end

  private
    def set_movie
      @movie = Movie.find(params[:id])
    end

end
