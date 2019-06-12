module MoviesHelper
  def genre_link(movie)
    valid_genre = movie.categories.map {|genre_object| link_to("#{genre_object.genre}", movies_path(category: genre_object))}
    no_valid_genre = movie.genre.split(", ") - movie.categories.map {|genre_object| genre_object.genre}
    (valid_genre + no_valid_genre).join(", ").html_safe
  end
end
