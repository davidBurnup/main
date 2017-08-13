class AddIsDraftToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :is_draft, :boolean
  end
end
