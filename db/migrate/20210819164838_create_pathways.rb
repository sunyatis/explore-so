class CreatePathways < ActiveRecord::Migration[6.0]
  def change
    create_table :pathways do |t|
      t.string :title
      t.string :headline
      t.string :description
      t.string :learn_your_way_text
      t.string :best_fit_link_1
      t.string :best_fit_link_2
      t.string :best_fit_link_3
      t.string :meta_description
      t.string :meta_keywords
      t.string :page_title 
      t.string :pathway_title
      t.string :landing_page
    end
  end
end

