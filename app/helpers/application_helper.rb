module ApplicationHelper
  def fav_include_movie?(movie)
    @current_favorite.line_items.map{|line_item| line_item.movie.id}.include?(movie.id)
  end
end
