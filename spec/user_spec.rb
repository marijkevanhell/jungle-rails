require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do

    it 'should save user when all required fields are set correctly' do
      @user = User.new(first_name: 'Tom', last_name: 'Watson', email: 'test@test.com', password: "123test", password_confirmation: "123test")
      expect(@user).to be_valid
    end

    it 'should provide an error message if first name not set' do
      @user = User.new(first_name: nil, last_name: 'Watson', email: 'test@test.com', password: "123test", password_confirmation: "123test")
      @user.save
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it 'should provide an error message if last name not set' do
      @user = User.new(first_name: 'Tom', last_name: nil, email: 'test@test.com', password: "123test", password_confirmation: "123test")
      @user.save
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end

    it 'should provide an error message if email not set' do
      @user = User.new(first_name: 'Tom', last_name: 'Watson', email: nil, password: "123test", password_confirmation: "123test")
      @user.save
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end


    it 'should provide an error message if password not set' do
      @user = User.new(first_name: 'Tom', last_name: 'Watson', email: 'test@test.com', password: nil, password_confirmation: nil)
      @user.save
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'should not save if password and password_confirmation do not match' do
      @user = User.new(first_name: 'Tom', last_name: 'Watson', email: 'test@test.com', password: "123test", password_confirmation: "456hello")
      @user.save 
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'should have a minimun password length' do
      @user = User.new(first_name: 'Tom', last_name: 'Watson', email: 'test@test.com', password: "1test", password_confirmation: "1test")
      @user.save
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 7 characters)")
    end
  end

  describe '.authenticate_with_credentials' do

    it 'returns user if succesfully authenticated' do
      @user = User.new(first_name: 'Tom', last_name: 'Watson', email: 'test@test.com', password: "123test", password_confirmation: "123test")
      @user.save
      @user_logged_in = User.authenticate_with_credentials('test@test.com', "123test")
      expect(@user_logged_in).to_not eq(nil)
    end

    it 'should authenticate user if email contains trailing spaces' do
      @user = User.new(first_name: 'Tom', last_name: 'Watson', email: 'test@test.com', password: "123test", password_confirmation: "123test")
      @user.save
      @user_logged_in = User.authenticate_with_credentials(' test@test.com ', "123test")
      expect(@user_logged_in).to_not eq(nil)
    end

    it 'should authenticate user if email in the wrong case' do
      @user = User.new(first_name: 'Tom', last_name: 'Watson', email: 'test@test.com', password: "123test", password_confirmation: "123test")
      @user.save
      @user_logged_in = User.authenticate_with_credentials('TEST@test.com', "123test")
      expect(@user_logged_in).to_not eq(nil)
    end
  end

end
