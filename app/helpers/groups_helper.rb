module GroupsHelper
  def cache_key_for_group_row(group)
    "group-#{current_user.id}-#{group.id}-#{group.updated_at}"
  end
  def cache_key_for_group_table
    "group-table-#{current_user.id}-#{Group.maximum(:updated_at)}"
  end
end
