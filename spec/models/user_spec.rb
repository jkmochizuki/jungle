require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    describe 'name' do
      it 'validates presence of name' do
        user = User.new(name: nil)
        user.validate
        expect(user.errors.full_messages).to include("Name can't be blank")
      end
    end

    describe 'email' do
      it 'validates presence of email' do
        user = User.new(email: nil)
        user.validate
        expect(user.errors.full_messages).to include("Email can't be blank")
      end

      it 'validates uniqueness of email' do
        user1 = User.create(name: 'Jane Doe', email: 'TEST@TEST.com', password: '123456', password_confirmation: '123456')
        user2 = User.new(name: 'John Doe', email: 'test@test.com', password: '123456', password_confirmation: '123456')
        user2.validate
        expect(user2.errors.full_messages).to include('Email has already been taken')
      end
    end

    describe 'password' do
      it 'validates presence of password' do
        user = User.new(password: nil)
        user.validate
        expect(user.errors.full_messages).to include("Password can't be blank")
      end

      it 'validates minimum length of password' do
        user = User.new(password: '12345')
        user.validate
        expect(user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
    end

    describe 'password_confirmation' do
      it 'validates presence of name' do
        user = User.new(password_confirmation: nil)
        user.validate
        expect(user.errors.full_messages).to include("Password confirmation can't be blank")
      end

      it 'validates that password and password_confirmation match' do
        user = User.new(password: '123456', password_confirmation: '134567')
        user.validate
        expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
    end
  end

  describe '.authenticate_with_credentials' do
    before do
      @user = User.create(name: 'Jane Doe', email: 'TEST@test.com', password: '123456', password_confirmation: '123456')
    end
    
    it 'authenticates the user credentials with case insensitive email' do
      authenticated_user = User.authenticate_with_credentials('TEST@test.com', '123456')
      expect(authenticated_user).not_to be_nil
      expect(authenticated_user.email.downcase).to eq('test@test.com')
    end

    it 'authenticates the user credentials if a visitor types in a few spaces before and/or after their email address' do
      authenticated_user = User.authenticate_with_credentials('  test@test.com  ', '123456')
      expect(authenticated_user).not_to be_nil
      expect(authenticated_user.email.downcase).to eq('test@test.com')
    end

    it 'returns nil when fails to authenticate' do
      user = User.authenticate_with_credentials('test@test.com', '1235')
      expect(user).to eq(nil)
    end
  end
end
