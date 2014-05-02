class ReviewsController < ApplicationController
  before_filter :ensure_logged_in, :only => [:edit, :create, :show, :update, :destroy]
  before_filter :load_product
  def show
  	@review = Review.find(params[:id])
  end

  def create
  	@review = @product.reviews.build(review_params)
  	@review.user_id = current_user.id
    respond_to do |format|
    	if @review.save
        format.html {redirect_to @product, notice: 'Review created succesfully'}
    	  format.js {} #finds views/reviews/create.js.erb
      else
        format.html {render :action => :show, alert: 'There was an error.' }
        format.js {}
    	end
    end

	end

	def destroy
		@review = Review.find(params[:id])
		@review.destroy
	end

  private

  def review_params
  	params.require(:review).permit(:comment, :product_id)
  end

  def load_product
  	@product = Product.find(params[:product_id])
  end
end
