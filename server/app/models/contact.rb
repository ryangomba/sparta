class Contact < ActiveRecord::Base
    default_scope order(:last_name)

    belongs_to :user
    
    def self.relations
        ['mom', 'grandma', 'aunt', 'grandpa', 'dad', 'sister', 'brother', 'uncle']
    end

    def to_s
        name = self.last_name
        name ? name += ", #{self.first_name}" : name = self.first_name
        name ? name : name = self.company
        name ? name : "Contact #{self.id}"
    end
    
    def fields
        [:email, :phone, :twitter, :facebook, :linkedin, :aim, :jabber]
    end
    
    def self.family_member?(nickname)
        if nickname
            nickname = nickname.downcase
            Contact.relations.each do |f|
                if nickname.include?(f) then return true end
            end
        end
        return false
    end
    
    def address_query
        return self.address.split().join('+').tr(' ','+')
    end

end