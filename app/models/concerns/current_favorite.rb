module CurrentFavorite
  def set_favorite
    if user_signed_in?
      set_user_favorite
    else
      if session[:favorite]
        @favorite = Favorite.find(session[:favorite])
      else
        @favorite = Favorite.create
        session[:favorite] = @favorite.id
      end
    end
  end


  def set_user_favorite
    if session[:favorite] #если есть сессия
      if current_user.favorite.nil?
#и отсутсвует у текущего пользователя закладки,
#присвоить закладки из сессии пользователю и обнулить сессию
        @favorite = Favorite.find(session[:favorite])
        session[:favorite] = nil
        @favorite.update(user: current_user)
      else
#если у пользователя уже создана закладка,
#перенести закладки из сессии в закладки пользователя,
#удалить анонимную закладку и обнулить сессию
        session_favorite = Favorite.find(session[:favorite])
        @favorite = Favorite.find_by(user: current_user)
        session_favorite.line_items.each do |line_item|
          line_item.update(favorite: @favorite)
        end
        session[:favorite] = nil
        session_favorite.line_items.reload
        session_favorite.destroy
        @favorite
      end
    else #если сессия отсутвует
      if current_user.favorite.nil?#на не предвиденный случай
        @favorite = current_user.build_favorite
        @favorite.save
      else
        @favorite = Favorite.find_by(user: current_user)
      end
    end
  end
end
