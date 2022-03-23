
module CurrentFavorite
  def set_favorite
    if user_signed_in?
      set_user_favorite
    else
      if cookies[:favorite]
        @favorite = Favorite.find(cookies[:favorite])
      else
        @favorite = Favorite.create
        cookies[:favorite] = {value: @favorite.id, expires: 4.day}
      end
    end
  end


  def set_user_favorite
    if cookies[:favorite] #если есть сессия
      if current_user.favorite.nil?
#и отсутсвует у текущего пользователя закладки,
#присвоить закладки из сессии пользователю и обнулить сессию
        @favorite = Favorite.find(cookies[:favorite])
        cookies.delete :favorite
        @favorite.update(user: current_user)
      else
#если у пользователя уже создана закладка,
#перенести закладки из сессии в закладки пользователя,
#удалить анонимную закладку и обнулить сессию
        cookies_favorite = Favorite.find(cookies[:favorite])
        @favorite = Favorite.find_by(user: current_user)
        cookies_favorite.line_items.each do |line_item|
          line_item.update(favorite: @favorite)
        end
        cookies.delete :favorite
        cookies_favorite.line_items.reload
        cookies_favorite.destroy
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
