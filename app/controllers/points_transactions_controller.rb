class PointsTransactionsController < InheritedResources::Base
  load_and_authorize_resource

  private

    def points_transaction_params
      params.require(:points_transaction).permit(:school_id, :trans_type, :points, :payment, :attendee, :event_start, :event_end, :course, :approved, :points_type, :trans_date)
    end
end

