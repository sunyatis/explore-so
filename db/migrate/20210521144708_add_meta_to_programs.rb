class AddMetaToPrograms < ActiveRecord::Migration[6.0]
  def change
    add_column :programs, :meta, :string
  end
end
