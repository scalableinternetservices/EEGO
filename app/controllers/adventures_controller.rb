class AdventuresController < ApplicationController
  before_action :require_user

  def index
    redirect_to '/users/sign_in' unless user_signed_in?
    location = params[:location]
    @adventures = Adventure.where("user_id=#{current_user.id}").paginate(:page => params[:page], :per_page => 10)
  end

  def new
    redirect_to '/users/sign_in' unless user_signed_in?
  end

  def create
    redirect_to '/users/sign_in' unless user_signed_in?
    @user = User.find(current_user.id)
    if (!params[:location].empty?) && (!params[:num_people].empty?) && (!params[:num_day].empty?) && (!params[:plan].empty?)
      @location = params[:location]
      @num_people = params[:num_people]
      @num_day = params[:num_day]
      @plan = params[:plan]
      @adventure  = Adventure.new({user_id: current_user.id, location: @location, num_people: @num_people, num_day: @num_day, plan: @plan})
      @adventure.save
      redirect_to :action => 'search', :location => @location
    else
      redirect_to '/adventures/new'
    end
  end

  def search
    @user = User.find(current_user.id)
    location = params[:location]
    @adventures = Adventure.where("location LIKE ?","%#{location}%").paginate(:page => params[:page], :per_page => 30)
  end

  def delete
    @user = User.find(current_user.id)
    @location = params[:location]
    @num_people = params[:num_people]
    @num_day = params[:num_day]
    @plan = params[:plan]
    @adventure  = Adventure.find_by({user_id: current_user.id, location: @location, num_people: @num_people, num_day: @num_day, plan: @plan})
    @adventure.destroy
    redirect_to '/adventures/index'
  end

  def edit_page
    @user = User.find(current_user.id)
    @location = params[:location]
    @num_people = params[:num_people]
    @num_day = params[:num_day]
    @plan = params[:plan]
  end

  def edit
    @user = User.find(current_user.id)
    @pre_location = params[:pre_location]
    @pre_num_people = params[:pre_num_people]
    @pre_num_day = params[:pre_num_day]
    @pre_plan = params[:pre_plan]
    @adventure = Adventure.find_by({user_id: current_user.id, location: @pre_location, num_people: @pre_num_people, num_day: @pre_num_day, plan: @pre_plan})
    location = params[:location]
    num_people= params[:num_people]
    num_day = params[:num_day]
    plan = params[:plan]
    if (!location.empty?) && (!num_people.empty?) && (!num_day.empty?) && (!plan.empty?)
      @adventure.update_attributes(:location => location, :num_people => num_people, :num_day => num_day, :plan => plan)
    end
    redirect_to '/adventures/index'
  end

  def show_detail
    @user = User.find(current_user.id)
    @location = params[:location]
    @num_people = params[:num_people]
    @num_day = params[:num_day]
    @plan = params[:plan]
  end
end
