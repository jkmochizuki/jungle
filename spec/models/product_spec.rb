require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    before do
      @category = Category.create(name: 'Evergreens')
    end

    describe 'name' do
      it 'validates presence of name' do
        product = Product.new(name: nil)
        product.validate
        expect(product.errors.full_messages).to include("Name can't be blank")
      end
    end

    describe 'price' do
      it 'validates presence of price' do
        product = Product.new(price_cents: nil)
        product.validate
        expect(product.errors.full_messages).to include("Price can't be blank")
      end
    end

    describe 'quantity' do
      it 'validates presence of quantity' do
        product = Product.new(quantity: nil)
        product.validate
        expect(product.errors.full_messages).to include("Quantity can't be blank")
      end
    end

    describe 'category' do
      it 'validates presence of category' do
        product = Product.new(category: nil)
        product.validate
        expect(product.errors.full_messages).to include("Category can't be blank")
      end
    end

    describe 'all fields' do
      it 'validates presence of all fields' do
        product = Product.new(name: 'Giant Tea', price_cents: 64.99, quantity: 0, category: @category)
        product.validate
        expect(product.errors.full_messages).to be_empty

        product.name = nil
        product.price_cents = nil
        product.quantity = nil
        product.category = nil
        product.validate
        expect(product.errors.full_messages).to include("Name can't be blank", "Price cents is not a number", "Quantity can't be blank", "Category can't be blank")
      end
    end
  end
end
