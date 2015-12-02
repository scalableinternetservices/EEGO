module NotificationsHelper
  def delete_friendship_path sender_user_id
    @friendship = Friendship.where("user_id=#{sender_user_id} AND friend_id=#{current_user.id}")
    return "/friends/#{@friendship[0].id}"
  end

  def cache_key_for_notification_row(notification)
    "notification-#{current_user.id}-#{notification.id}-#{notification.updated_at}"
  end
  def cache_key_for_group_table
    "notification-table-#{current_user.id}-#{Notification.maximum(:updated_at)}"
  end

end
