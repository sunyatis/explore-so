class PointsTransactionsController < InheritedResources::Base
  load_and_authorize_resource


    def index
        @pending = PointsTransaction.accessible_by(current_ability, :read).where(:approved => "Pending")
        @points_total = PointsTransaction.accessible_by(current_ability, :read).where(:approved => "Pending")
        @total_points = PointsTransaction.accessible_by(current_ability, :read).where(:approved => "Approved").sum(:points)
        @available_points = PointsTransaction.accessible_by(current_ability, :read).where.not(:approved => "Rejected").sum(:points)

    end
    
    def filters
        @filterrific = initialize_filterrific(
            PointsTransaction,
            params[:filterrific],
     select_options: {
              sorted_by: PointsTransaction.options_for_sorted_by,
             with_school_id: School.options_for_select
           }#,
    #        persistence_id: 'shared_key',
    #              default_filter_params: {},
    #              available_filters: [],
                      ) or return
                      @points_transactions = @filterrific.find.page(params[:page])
                          # Respond to html for initial page load and to js for AJAX filter updates.
                          respond_to do |format|
                            format.html
                            format.js
                          end

                        # Recover from invalid param sets, e.g., when a filter refers to the
                        # database id of a record that doesn’t exist any more.
                        # In this case we reset filterrific and discard all filter params.
                      #  rescue ActiveRecord::RecordNotFound => e
                          # There is an issue with the persisted param_set. Reset it.
                      #    puts "Had to reset filterrific params: #{ e.message }"
                       #   redirect_to(reset_filterrific_url(format: :html)) and return  
      end
    
    
    
    

  private

    def points_transaction_params
      params.require(:points_transaction).permit(:school_id, :trans_type, :points, :payment, :attendee, :event_start, :event_end, :course, :approved, :points_type, :trans_date)
    end
    
   
end

