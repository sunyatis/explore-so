class UpdatePointsTranactionSchoolId < ActiveRecord::Migration
  def change
    rename_column :points_transactions, :campus_id, :school_id
  end
end
