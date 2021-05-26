class AddMetaToPrograms < ActiveRecord::Migration[6.0]
  def change
    add_column :programs, :meta_keywords, :string
    add_column :programs, :meta_desc, :string
  end
end
