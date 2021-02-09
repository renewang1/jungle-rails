require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    # validation tests/examples here
    it 'should save if all four fields are filled' do
      @category = Category.new({name: 'name'})
      @product = Product.new({name: 'John', quantity: 400, price: 300, category: @category})
      @product.save
      expect(@product.name).not_to be_empty
    end
    it 'should save quantity if fields are filled' do
      @category = Category.new({name: 'name'})
      @product = Product.new({name: 'John', quantity: 400, price: 300, category: @category})
      @product.save
      expect(@product.quantity).to be == 400
    end
    it 'should save price if all fields are filled' do
      @category = Category.new({name: 'name'})
      @product = Product.new({name: 'John', quantity: 400, price: 300, category: @category})
      @product.save
      expect(@product.price).to be == 300
    end
    it 'should save category if all fields are filled' do
      @category = Category.new({name: 'name'})
      @product = Product.new({name: 'John', quantity: 400, price: 300, category: @category})
      @product.save
      expect(@product.category).to be == @category
    end
    it 'should have an error if a field is not filled' do
      @category = Category.new({name: 'name'})
      @product = Product.new({name: 'John', quantity: nil, price: 300, category: @category})
      @product.save
      expect(@product.errors.messages[:quantity]).to eq ["can't be blank"]
    end
  end
end