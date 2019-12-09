class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :current_favorite

  private
    def current_favorite
      if session[:favorite_id]
        favorite = ::Favorite.find_by(:id => session[:favorite_id])
        if favorite.present?
          @current_favorite = favorite
        else
          session[:favorite_id] = nil
        end
      end

      if session[:favorite_id] == nil
        @current_favorite = Favorite.create
        session[:favorite_id] = @current_favorite.id
      end
    end
end
