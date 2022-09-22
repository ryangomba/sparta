class CreateContacts < ActiveRecord::Migration
    def change
        create_table :contacts do |t|
            t.string :uid
            t.string :first_name
            t.string :last_name
            t.string :company
            t.string :email
            t.string :phone
            t.string :address
            t.string :twitter
            t.string :facebook
            t.string :linkedin
            t.string :aim
            t.string :jabber
            t.string :nickname
            t.boolean :family
            
            t.integer :user_id
            
            t.timestamps
        end
    end
end
