require 'rails_helper'
require 'spec_helper'

RSpec.describe 'UsersLogins', type: :request do
  describe 'GET /users_logins' do
    before :each do
      @user = User.create(email: 'user@example.com', password: 'password')
    end

    it 'Successful Login' do
      get new_user_session_path
      post '/users/sign_in', params: { user: { email: 'user@example.com', password: 'password' } }
    end

    it 'Failed Login' do
      get new_user_session_path
      post '/users/sign_in', params: { user: { email: 'mistake@example.com', password: 'password' } }
    end
  end
end
