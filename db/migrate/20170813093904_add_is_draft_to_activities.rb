class AddIsDraftToActivities < ActiveRecord::Migration[4.2]
  def change
    add_column :activities, :is_draft, :boolean
  end
end
