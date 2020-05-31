module ApplicationHelper
  def favorite_include_movie?(movie)
    @favorite.line_items.map{|line_item| line_item.movie.id}.include?(movie.id)
  end
end
