module ApplicationHelper
  def cache_key_for_navigation_bar(current_user)
    current_user == nil ? "current_user-none" : "current_user-#{current_user.id}"
  end
end
