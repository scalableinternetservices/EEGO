class FriendsController < ApplicationController
  before_action :require_user

  def index
    search_kw = params[:search]
    if search_kw and search_kw.length > 0
      @friends = User.includes(:friendships).where("email LIKE '%#{search_kw}%' AND friend_id=#{current_user.id}").references(:friendships)
      @friend_ids = []
      @friends.each do |f|
        @friend_ids.push f.id
      end
      query_str = "email LIKE '%#{search_kw}%'"
      if !@friend_ids.empty?
        query_str += " AND id NOT IN #{array_to_str(@friend_ids)}"
      end
      @users = User.where(query_str)
      @no_user = 0
      if @users.empty? and @friends.empty?
        @no_user = 1
      end
    else
      @friends = User.includes(:friendships).where("friend_id=#{current_user.id}").references(:friendships)
      @users = []
      @friends.each do |f|
        @users.push f if f.friendships[0].status == 1
      end
      if !@users.empty?
        @no_user = 3
      else
        @no_user = 2
      end
    end
  end

  def create
    redirect_to '/users/sign_in' unless user_signed_in?
    @r_friendship = Friendship.where("user_id=#{friend_params} AND friend_id=#{current_user.id}")
    if @r_friendship.empty?
      @friendship = Friendship.new({user_id: current_user.id, friend_id: friend_params.to_i, status: 2})
      @friendship.save    #should add error handling
      @notification = Notification.new({sender_user_id: current_user.id, user_id: friend_params.to_i, message: User.find(current_user.id).email + " want to add you as a friend", status: 0})
      @notification.save    #should add error handling
      redirect_to :back
    else
      @friendship = Friendship.new({user_id: current_user.id, friend_id: friend_params.to_i, status: 1})
      @r_friendship[0].status = 1
      @friendship.save
      @r_friendship[0].save
      invitation_msg = '"% want to add you as a friend%"'
      @notifications = Notification.where("user_id=#{current_user.id} AND sender_user_id=#{friend_params} AND message LIKE #{invitation_msg}")
      if @notifications
        @notifications.each do |n|
          n.destroy
        end
      end
      redirect_to :back
    end
  end

  def update
    @friendship = Friendship.where("user_id=#{params[:sender_user_id]} AND friend_id=#{params[:receiver_user_id]}")
    redirect_to '/friends' unless !@friendship.empty?    #should exist a notification site
    @friendship = @friendship[0]
    @friendship.status = 1
    @friendship.save    #should exist cases to deal with error
    @reverse_f = Friendship.new({user_id: params[:receiver_user_id], friend_id: params[:sender_user_id], status: 1})
    @reverse_f.save    #should exist cases to deal with error
    @notification = Notification.find(params[:n_id])
    if @notification
      @notification.destroy
    end
    redirect_to :back
  end

  def destroy
    @friendship = Friendship.find(params[:id])
    if @friendship
      @friendship.destroy
    end
    @notification = Notification.find(params[:n_id])
    if @notification
      @notification.destroy
    end
    redirect_to :back
  end

private
  def friend_params
    params.require(:friend)
  end

  def array_to_str(a)
    s = '('
    a.each do |e|
      s = s + e.to_s + ','
    end
    s[-1] = ')'
    return s
  end
end
