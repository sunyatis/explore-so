class PointsTransactionsController < InheritedResources::Base
  load_and_authorize_resource

   def index
      @pending = PointsTransaction.accessible_by(current_ability, :read).where(:approved => "Pending")
      @points_total = PointsTransaction.accessible_by(current_ability, :read).where(:approved => "Pending")
      @total_points = PointsTransaction.accessible_by(current_ability, :read).where(:approved => "Approved").sum(:points)
      @available_points = PointsTransaction.accessible_by(current_ability, :read).where.not(:approved => "Rejected").sum(:points)
    end


  private

    def points_transaction_params
      params.require(:points_transaction).permit(:school_id, :trans_type, :points, :payment, :attendee, :event_start, :event_end, :course, :approved, :points_type, :trans_date)
    end
    
   
end

