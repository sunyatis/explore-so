class AddRankuFields < ActiveRecord::Migration[6.0]
  def change
      add_column :programs, :ranku_id, :string
      add_column :programs, :active, :boolean, :default => true
      add_column :programs, :asynchronous, :boolean
  end
end
