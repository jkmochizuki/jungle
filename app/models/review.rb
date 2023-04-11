class Review < ApplicationRecord
  belongs_to :user
  belongs_to :product
  
  validates :product_id, :user_id, :description, :rating, presence: true
end
