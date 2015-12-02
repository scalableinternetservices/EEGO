class AdventuresController < ApplicationController
  before_action :require_user

  def index
    redirect_to '/users/sign_in' unless user_signed_in?
    location = params[:location]
    adventure_max_updated = Adventure.maximum("updated_at").try(to_s, :number)
    @adventures = Rails.cache.fetch("my_adventure_#{adventure_max_updated}_#{current_user.id}", expires_in: 30.seconds) do
        Adventure.where("user_id=#{current_user.id}").to_a
    end
  end

  def new
    redirect_to '/users/sign_in' unless user_signed_in?
  end

  def create
    redirect_to '/users/sign_in' unless user_signed_in?
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
    location = params[:location]
    adventure_max_updated = Adventure.maximum("updated_at").try(to_s, :number)
    @adventures = Rails.cache.fetch("search_for_adventure_#{adventure_max_updated}_#{location}", expires_in: 2.hours) do
        Adventure.where("location LIKE ?","%#{location}%").to_a
      end
  end

  def delete
    @location = params[:location]
    @num_people = params[:num_people]
    @num_day = params[:num_day]
    @plan = params[:plan]
    @adventure  = Adventure.find_by({user_id: current_user.id, location: @location, num_people: @num_people, num_day: @num_day, plan: @plan})
    @adventure.destroy
    redirect_to '/adventures/index'
  end

  def edit_page
    @location = params[:location]
    @num_people = params[:num_people]
    @num_day = params[:num_day]
    @plan = params[:plan]
  end

  def edit
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
    @location = params[:location]
    @num_people = params[:num_people]
    @num_day = params[:num_day]
    @plan = params[:plan]
  end
end
