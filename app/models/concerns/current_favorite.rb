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
    if session[:favorite]
      puts "if session #{session[:favorite]}"
      if current_user.favorite.nil?
        puts "step 1."
        @favorite = Favorite.find(session[:favorite])
        session[:favorite] = nil
        @favorite.update(user: current_user)
      else
        puts "step 2."
        session_favorite = Favorite.find(session[:favorite])
        @favorite = Favorite.find_by(user: current_user)
        session_favorite.line_items.each do |line_item|
          line_item.update(favorite: @favorite)
        end
        session[:favorite] = nil
        session_favorite.destroy
        @favorite
      end
    else
      puts "if session nil"
      if current_user.favorite.nil?
        puts "step 3."
        @favorite = current_user.build_favorite
        @favorite.save
      else
        puts "step 4."
        @favorite = Favorite.find_by(user: current_user)
      end
    end
  end
end
