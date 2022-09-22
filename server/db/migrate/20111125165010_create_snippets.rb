class CreateSnippets < ActiveRecord::Migration
    def change
        create_table :snippets do |t|
            t.text :text
            t.string :ip
            t.string :latitude
            t.string :longitude
            t.integer :cusses
            
            t.integer :user_id
            
            t.timestamps
        end
    end
end
