class CreateIps < ActiveRecord::Migration
    def change
        create_table :ips do |t|
            t.string :address
            t.string :latitude
            t.string :longitude
            
            t.timestamps
        end
    end
end
