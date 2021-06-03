class AddFlagsToSources < ActiveRecord::Migration[6.1]
  def change
    add_column :sources, :active, :boolean, null: false, default: true
    add_column :sources, :site_visible, :boolean, null: false, default: true
    add_column :sources, :post_to_discord, :boolean, null: false, default: true
  end
end
