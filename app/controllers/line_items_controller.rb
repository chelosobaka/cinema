class LineItemsController < ApplicationController


  def create
    # Find associated product and current cart
    chosen_movie = Movie.find(params[:movie_id])
    current_favorite = @current_favorite
    # If cart already has this product then find the relevant line_item and iterate quantity otherwise create a new line_item for this product
    if current_favorite.movies.include?(chosen_movie)
      # Find the line_item with the chosen_product
      @line_item = current_favorite.line_items.find_by(:movie_id => chosen_movie)
      # Iterate the line_item's quantity by one
    else
      @line_item = LineItem.new
      @line_item.favorite = current_favorite
      @line_item.movie = chosen_movie
    end

    # Save and redirect to cart show path
    @line_item.save
    redirect_to request.referrer
  end

  def destroy
    @line_item = LineItem.find_by movie_id: params[:id], favorite_id: @current_favorite.id
    @line_item.destroy
    redirect_to request.referrer
  end

end
