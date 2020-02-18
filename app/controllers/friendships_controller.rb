class FriendshipsController < ApplicationController
  before_action :setup_friends

  def create
    Friendship.request(@user, @friend)
    flash[:notice] = 'Friend request sent.'
    redirect_to user_path(@friend)
  end

  def accept
    if @user.requested_friends.include?(@friend)
      Friendship.accept(@user, @friend)
      flash[:notice] = "Friend accepted!"
    else
      flash[:notice] = "No friendship available."
    end
    redirect_to user_path(@friend)
  end

  def decline
    if @user.requested_friends.include?(@friend)
      Friendship.breakup(@user, @friend)
      flash[:notice] = "Friend declined"
    else
      flash[:notice] = "No friendship available."
    end
    redirect_to user_path(@friend)
  end

  def cancel
    if @user.pending_friends.include?(@friend)
      Friendship.breakup(@user, @friend)
      flash[:notice] = 'Friendship request canceled.'
    else
      flash[:notice] = "No friendship available."
    end
    redirect_to user_path(@friend)
  end

  def delete
    if @user.friends.include?(@friend)
      Friendship.breakup(@user, @friend)
      flash[:notice] = "Friend deleted!"
    else
      flash[:notice] = "You are not friend with this person."
    end
    redirect_to user_path(@friend)
  end

  private

  def setup_friends
    @user = current_user
    @friend = User.find(params[:id])
  end
end
