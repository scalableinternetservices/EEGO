class Adventure < ActiveRecord::Base
  belongs_to :user
  def self.fetch(location)
    Rails.cache.fetch("adventure_#{location}") { Adventure.where("location LIKE ?","%#{location}%")}
  end

  def after_save
    Rails.cache.write("adventure_#{location}", self)
  end

  def after_destroy
    Rails.cache.delete("adventure_#{location}")
  end
end
