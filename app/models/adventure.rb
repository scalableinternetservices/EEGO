class Adventure < ActiveRecord::Base
  belongs_to :user
  def self.search_by_location(location)
    @adventures ||= Rails.cache.fetch("adventure_#{location}", expires_in: 1.minute) do
      @adventures = Adventure.where("location LIKE ?","%#{location}%").to_a
    end
    @adventures

    # Rails.cache.fetch("adventure_#{location}") {Adventure.where("location LIKE ?","%#{location}%")}
  end

  # def after_save
  #   Rails.cache.write("adventure_#{location}", self)
  # end
  #
  # def after_destroy
  #   Rails.cache.delete("adventure_#{location}")
  # end
end
