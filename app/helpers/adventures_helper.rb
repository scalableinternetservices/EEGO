module AdventuresHelper
  def cache_key_for_adventure_row(adventure)
    "adventure-#{adventure.id}-#{adventure.updated_at}"
  end
  def cache_key_for_adventure_table
    "adventure-table-#{Adventure.maximum(:updated_at)}"
  end
end
