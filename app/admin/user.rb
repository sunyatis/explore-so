ActiveAdmin.register User do
menu parent: 'Manage Navigator', label: 'Users'
  # See permitted parameters documentation:
   # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
   permit_params :email, :password, :password_confirmation, :role, :school_id
   
   controller do

      def update
        if params[:user][:password].blank?
          params[:user].delete("password")
          params[:user].delete("password_confirmation")
        end
        super
      end

    end

     index do
         column :email
         column :current_sign_in_at
         column :last_sign_in_at
         column :sign_in_count
         column :role
         actions
     end

     filter :email

     form do |f|
         f.inputs "User Details" do
             f.input :email
             f.input :password
             f.input :password_confirmation
             #f.input :role, as: :radio, collection: {None: "none", Administrator: "admin", ADI: "ADI"}
             f.input :school_id, as: :select, :collection => School.pluck(:name, :id)
             f.input :role, as: :radio, collection: User::ROLES

             
         end
         f.actions
     end
end
