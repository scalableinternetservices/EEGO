class GroupsController < ApplicationController
  before_action :require_user

  def index
    @group_entries = Group.where("user_id=#{current_user.id}")
    @groups = []
    @group_entries.each do |g|
      @cur_group = {name: g.name, num_people: Group.where("name=\"#{g.name}\"").count};
      #@cur_group.name = g.name
      # @cur_group.num_people = Group.where("name=#{g.name}").count
      @groups.push(@cur_group)
    end
  end

  def new
    @friendships = current_user.friendships
    @friends = []
    @friendships.each do |f|
      @friends.push User.find(f.friend_id) if f.status == 1
    end
  end

  def create
    group_name = params[:group_name]
    @my_entry = Group.new({name: group_name, user_id: current_user.id})
    @my_entry.save
    params.each do |id, v|
      if v == "1"
        @group_entry = Group.new({name: group_name, user_id: id.to_i})
        @group_entry.save
      end
    end
    redirect_to '/groups'
  end

  def delete
    @user = User.find(current_user.id)
    @group_name = params[:group_name]
    @groups  = Group.find_by({name: @group_name, user_id: current_user.id})
    @groups.destroy
    redirect_to :back
  end

end
