class CreateUsers < ActiveRecord::Migration
    def change
        create_table :users do |t|
            t.string :device_id
            
            t.integer :contact_id
            
            t.timestamps
        end
    end
end
