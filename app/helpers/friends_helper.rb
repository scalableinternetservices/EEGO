module FriendsHelper
  def is_friend? user
    !Friendship.where("user_id=#{current_user.id} AND friend_id=#{user.id} AND status=1").empty?
  end

  def is_pending_request? user
    !Friendship.where("user_id=#{current_user.id} AND friend_id=#{user.id} AND status=2").empty?
  end

  def cache_key_for_friend_row(user)
    "friend-#{current_user.id}-#{user.id}-#{user.notifications.maximum(:updated_at)}-#{params[:search]}"
  end

  def cache_key_for_friend_table
   "friend-table-#{current_user.id}-#{Friendship.maximum(:updated_at)}-#{params[:search]}"
  end
end
