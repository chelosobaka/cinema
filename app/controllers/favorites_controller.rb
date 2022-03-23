class FavoritesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_favorite
  def show
     @favorite
  end


  def destroy
    @favorite.destroy
    cookies.delete :favorite_id
    redirect_to root_path
  end

  private
  def invalid_favorite
    logger.error("Attempt to access invalid favorite #{params[:id]}")
    redirect_to root_path, notice: "that favorite doesn't exist"
  end

end
