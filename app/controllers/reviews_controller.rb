class ReviewsController < InheritedResources::Base

  before_action :set_movie
  before_action :authenticate_user!

  def create
    @review = @movie.reviews.build(review_params)
    @review.user = current_user
    respond_to do |format|
      if @review.save
        format.html {redirect_to request.referrer, notice: 'Комментарий успешно создан.'}
      else
        format.html {redirect_to movie_path(@movie), alert: "Комментарий не был создан."}
      end
    end
  end

  private

    def set_movie
      @movie = Movie.find(params[:movie_id])
    end

    def review_params
      params.require(:review).permit(:body)
    end

end
