module AdventuresHelper
  def cache_key_for_adventure_row(adventure)
    "adventure-#{adventure.id}-#{adventure.updated_at}-#{params[:location]}"
  end
  def cache_key_for_adventure_table
    "adventure-table-#{Adventure.maximum(:updated_at)}-#{params[:location]}"
  end

  def cache_key_for_my_adventure_row(adventure)
    "adventure-#{current_user.id}-#{adventure.id}-#{adventure.updated_at}-#{params[:location]}"
  end
  def cache_key_for_my_adventure_table
    "adventure-table-#{current_user.id}-#{Adventure.maximum(:updated_at)}-#{params[:location]}"
  end
end
