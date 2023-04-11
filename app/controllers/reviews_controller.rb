class ReviewsController < ApplicationController

  def create
    @review.user = current_user
    @review.product_id = params[:product_id]
    if @review.save
      redirect_to product_path(params[:product_id])
    else
      redirect_to product_path(params[:product_id])
    end
  end

  def destroy
    @delete.destroy
    redirect_to product_path(@delete.product_id)
  end

  private
    def review_params
      params.require(:review).permit(:description, :rating)
    end
end


class ReviewsController < ApplicationController
  before_action :new_review, only: [:create]
  before_action :delete_review, only: [:destroy]

  def create
    @review.user = current_user
    @review.product_id = params[:product_id]
    if @review.save
      redirect_to product_path(params[:product_id])
    else
      redirect_to product_path(params[:product_id])
    end
  end

  def destroy
    @delete.destroy
    redirect_to product_path(@delete.product_id)
  end

  private

  def review_params
    params.require(:review).permit(:description, :rating)
  end

  def new_review
    @review = Review.new(review_params)
  end

  def delete_review
    @delete = Review.find(params[:id])
  end
end
