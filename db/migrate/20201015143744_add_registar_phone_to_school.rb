class AddRegistarPhoneToSchool < ActiveRecord::Migration[6.0]
    def change
      add_column :schools, :registrar_phone, :string
    end
end
