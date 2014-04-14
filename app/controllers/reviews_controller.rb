class ReviewsController < ApplicationController
  def show
  	@review = Review.find(params[:id])
  end

  def create
  	@review = @product.reviews.build(review_params)
  	@review.user_id = current_user.id
  	if @review.save
  		redirect_to products_path, notice: 'Review created succesfully'
  	else
  		render :action => :show
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
