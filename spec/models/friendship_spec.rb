require 'rails_helper'

RSpec.describe Friendship, type: :model do
  before :each do
    @user = User.create(email: 'new1@dunno.com', name: 'new1', password: '123456')
    @friend = User.create(email: 'new2@dunno.com', name: 'new2', password: '123456')
    @friendship = Friendship.create(user: @user, friend: @friend, status: 'pending')
  end
  context 'with valid user and friend details' do
    it 'should create a friendship(pending)' do
      expect(@friendship).to be_valid
    end
  end
end
