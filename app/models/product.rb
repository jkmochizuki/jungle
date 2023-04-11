class Product < ApplicationRecord
  has_many :reviews
  
  monetize :price_cents, numericality: true
  mount_uploader :image, ProductImageUploader

  belongs_to :category

  validates :name, presence: true
  validates :price, presence: true
  validates :quantity, presence: true
  validates :category, presence: true

  def average_rating
    if reviews.loaded?
      reviews.average(:rating).to_f.round(1)
    else
      reviews.average(:rating)
    end
  end

  def count_rating
    reviews.count(:rating)
  end
end
