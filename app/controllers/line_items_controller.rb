class LineItemsController < ApplicationController
  include CurrentFavorite
  before_action :set_favorite, only: [:create, :destroy]

  def create
    chosen_movie = Movie.find(params[:movie_id])
    current_favorite = @favorite
    unless current_favorite.movies.include?(chosen_movie)
      @line_item = LineItem.new
      @line_item.favorite = current_favorite
      @line_item.movie = chosen_movie
      @line_item.save
      redirect_to request.referrer
    end
  end

  def destroy
    @line_item = LineItem.find_by movie_id: params[:id], favorite_id: @favorite.id
    @line_item.destroy
    redirect_to request.referrer
  end

end
