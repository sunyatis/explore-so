class AddApproverCommentsToPointsTransactions < ActiveRecord::Migration
  def change
    add_column :points_transactions, :approver_comments, :string
  end
end
