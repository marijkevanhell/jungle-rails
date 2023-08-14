require 'rails_helper'

RSpec.describe Product, type: :model do
  before do
    @category = Category.new(name: 'cacti')
    @category.save
  end
  
  describe 'Validations' do

    it 'ensures that a product with all four fields set will indeed save successfully' do
      @product = Product.new(name: 'sword fern', price: 100, quantity: 3, category: @category)
      expect(@product).to be_valid
    end

    it 'fails to save when name is not set' do
      @product = Product.new(name: nil, price: 100, quantity: 3, category: @category)
      @product.save
      expect(@product.errors.full_messages).to include("Name can't be blank")
      expect(@product).to_not be_valid
    end

    it 'fails to save when price is not set' do
      @product = Product.new(name: 'sword fern', quantity: 3, category: @category)
      @product.save
      expect(@product.errors.full_messages).to include("Price can't be blank")
      expect(@product).to_not be_valid
    end

    it 'fails to save when quantity is not set' do
      @product = Product.new(name: 'sword fern', price: 100, quantity: nil, category: @category)
      @product.save
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
      expect(@product).to_not be_valid
    end

    it 'fails to save when category is not set' do
      @product = Product.new(name: 'sword fern', price: 100, quantity: 3, category: nil)
      @product.save
      expect(@product.errors.full_messages).to include("Category can't be blank")
      expect(@product).to_not be_valid
    end
  end

end