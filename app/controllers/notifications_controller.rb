class NotificationsController < ApplicationController
  before_action :require_user
  def index
    notification_maximum_updated = Notification.maximum("updated_at").try(to_s, :number)
    @user = Rails.cache.fetch("my_notifications_#{notification_maximum_updated}_#{current_user.id}") do
        User.find(current_user.id)
        end
    @notifications = @user.notifications
  end

  def create
    #@notification = Notification.create(:sender_user_id => current_user.id, :message => User.find(current_user.id]).email + " want to add you as a friend", :user_id => notification_params[:receiver_user_id] )
    #@notification.save
    #redirect_to :back
  end

  private
  def notification_params
    params.require(:receiver_user_id)
  end
end
