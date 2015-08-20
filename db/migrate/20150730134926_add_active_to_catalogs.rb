class AddActiveToCatalogs < ActiveRecord::Migration
  def change
    add_column :catalogs, :active, :boolean, :default => false
  end
end
