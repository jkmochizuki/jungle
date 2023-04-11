require 'rails_helper'

RSpec.describe Order, type: :request do
  describe 'After creation' do
    before do
      @category = Category.create!(name: 'Test Category')
      @user = User.create!(name: 'Test User', email: 'email@test.com', password: 'password', password_confirmation: 'password')
      @product1 = Product.create!(name: 'Test Product1', description:'Test Description1', price_cents: 2000, quantity: 50, category: @category)
      @product2 = Product.create!(name: 'Test Product2', description:'Test Description2', price_cents: 4000, quantity: 20, category: @category)
    end

    it 'deducts quantity from products based on their line item quantities' do
      @order = Order.new(email: @user.email, total_cents: 4000, stripe_charge_id: '123')
      @order.line_items.new(product: @product1, quantity: 2, item_price: @product1.price_cents, total_price: 4000)
      @order.save!

      @order.update_product_quantities
      expect(@product1.reload.quantity).to eq(48)
    end

    it 'does not deduct quantity from products that are not in the order' do
      @order = Order.new(email: @user.email, total_cents: 4000, stripe_charge_id: '123')
      @order.line_items.new(product: @product1, quantity: 2, item_price: @product1.price_cents, total_price: 4000)
      @order.save!

      expect(@product2.reload.quantity).to eq(20)
    end
  end
end 