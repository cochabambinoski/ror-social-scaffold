class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User', foreign_key: 'friend_id'

  def self.exists?(user, friend)
    !find_by_user_id_and_friend_id(user, friend).nil?
  end

  def self.request(user, friend)
    return if (user == friend) || Friendship.exists?(user, friend)

    transaction do
      create(user: user, friend: friend, status: 'pending')
      create(user: friend, friend: user, status: 'requested')
    end
  end

  def self.accept(user, friend)
    transaction do
      accept_one_side(user, friend)
      accept_one_side(friend, user)
    end
  end

  def self.breakup(user, friend)
    transaction do
      destroy(find_by_user_id_and_friend_id(user.id, friend.id).id)
      find_by_user_id_and_friend_id(friend.id, user.id).destroy
    end
  end

  def self.accept_one_side(user, friend)
    request = find_by_user_id_and_friend_id(user, friend)
    request.status = 'accepted'
    request.save!
  end
end
