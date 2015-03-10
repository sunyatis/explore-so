class ProgramsController < ApplicationController
load_and_authorize_resource

def index
    @filterrific = initialize_filterrific(
        Program,
        params[:filterrific],
 select_options: {
          sorted_by: Program.options_for_sorted_by,
         with_school_id: School.options_for_select
       }#,
#        persistence_id: 'shared_key',
#              default_filter_params: {},
#              available_filters: [],
                  ) or return
                  @programs = @filterrific.find.page(params[:page])
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



  def my_programs
    @programs = Program.accessible_by(current_ability, :read)
  end




















  private

    def program_params
      params.require(:program).permit(:prog_title, :description, :subjectarea_id, :prog_level, :levelabb_id, :school, :duration, :delivery_method, :prerequisites, :program_url, :registration_url, :open_suny, :per_courses_online, :synchronous, :synchronous_text, :tutoring, :tutoring_name, :tutoring_phone, :tutoring_email, :tutoring_url, :helpdesk, :helpdesk_phone, :helpdesk_email, :helpdesk_url, :concierge, :concierge_phone, :concierge_name, :concierge_email, :experiential_learning, :experiential_text, :plas, :plas_text, :accelerated, :accelerated_text, :summary, :level_expanded, :sed, :apply_now_url, :school_attributes[:address1])
    end
    
   
  
end

