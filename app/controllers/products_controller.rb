class ProductsController < ApplicationController

  def index
    @products = Product.all.order(created_at: :desc)
  end

  def show
    @product = Product.find params[:id]
    @review = Review.new
    @current_user = current_user
    @average_rating = @product.average_rating
    @count_rating = @product.count_rating
    @reviews = Review.all.order(created_at: :desc).where(product_id: params[:id]).joins(:user)
  end
end