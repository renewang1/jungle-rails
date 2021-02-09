require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do 
    it 'should not save if passwords do not match' do
      @user = User.new({name: 'John', email: 'John@gmail.com', password: "1234", password_confirmation: "123"})
      @user.save
      expect(@user.errors.messages[:password_confirmation]).to eq ["doesn't match Password"]
    end
    it 'should not save if one password is missing' do
      @user = User.new({name: 'John', email: 'John@gmail.com', password: "1234"})
      @user.save
      expect(@user.errors.messages[:password_confirmation]).to eq ["can't be blank"]
    end
    it 'should not save if email already exists in database' do
      @user = User.new({name: 'John', email: 'John@gmail.com', password: '1234', password_confirmation: '1234'})
      @user.save
      @user2 = User.new({name: 'John', email: 'John@gmail.com', password: '123', password_confirmation: '123'})
      @user2.save
      expect(@user2.errors.messages[:email]).to eq ["has already been taken"]
    end
    it 'should not save password is too short' do
      @user = User.new({name: 'John', email: 'John@gmail.com', password: '12', password_confirmation: '12'})
      @user.save
      expect(@user.errors.messages[:password]).to eq ["is too short (minimum is 3 characters)"]
    end
  end
  describe '.authenticate_with_credentials' do
    # examples for this class method here
    it 'should return the instance of the user if they exist' do
      @user = User.new({name: 'John', email: 'John@gmail.com', password: '1234', password_confirmation: '1234'})
      @user.save
      valid = User.authenticate_with_credentials('John@gmail.com', '1234')
      expect(valid).to_not be_nil
    end
    it 'should return nil if user does not exist' do
      @user = User.new({name: 'John', email: 'John@gmail.com', password: '1234', password_confirmation: '1234'})
      valid = User.authenticate_with_credentials('John@gmail.com', '1234')
      expect(valid).to be_nil
    end
    it 'should return data if user inputs email with whitespace' do
      @user = User.new({name: 'John', email: 'John@gmail.com', password: '1234', password_confirmation: '1234'})
      @user.save
      valid = User.authenticate_with_credentials('   John@gmail.com', '1234')
      expect(valid).to_not be_nil
    end
    it 'should return data if user inputs email with different cases' do
      @user = User.new({name: 'John', email: 'John@gmail.com', password: '1234', password_confirmation: '1234'})
      @user.save
      valid = User.authenticate_with_credentials('JOHN@gmail.com', '1234')
      expect(valid).to_not be_nil
    end
  end
end
