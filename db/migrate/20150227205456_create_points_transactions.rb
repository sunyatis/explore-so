class CreatePointsTransactions < ActiveRecord::Migration
  def change
    create_table :points_transactions do |t|
      t.integer :campus_id
      t.string :trans_type
      t.integer :points
      t.integer :payment
      t.string :attendee
      t.date :event_start
      t.date :event_end
      t.string :course
      t.string :approved
      t.string :points_type
      t.string :trans_date

      t.timestamps null: false
    end
  end
end
