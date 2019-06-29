class FavoritesController < ApplicationController
  def show
    @favorite = @current_favorite
  end

  def destroy
    @favorite = @current_favorite
    @favorite.destroy
    session[:favorite_id] = nil
    redirect_to root_path
  end
end
