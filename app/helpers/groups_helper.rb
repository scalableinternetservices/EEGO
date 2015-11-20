module GroupsHelper
  def cache_key_for_group_row(group)
    "group-#{group.id}-#{group.updated_at}"
  end
  def cache_key_for_group_table
    "group-table-#{Group.maximum(:updated_at)}"
  end
end
