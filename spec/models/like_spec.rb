# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Like, type: :model do
  before :each do
    @user = User.create!(email: 'foobar7@example.com', name: 'foobar', password: 'foobar')
    @post = Post.create!(content: 'text123', user_id: @user.id)
    @like = Like.create(user_id: @user.id, post_id: @post.id)
  end

  context 'with valid details' do
    it 'should create a postlike' do
      expect(@like).to be_valid
    end
  end
end
