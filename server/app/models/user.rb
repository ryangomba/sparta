class User < ActiveRecord::Base

    belongs_to :contact
    has_many :snippets
    has_many :contacts

    validates_presence_of :device_id

    def to_s
        if self.contact.nil? then self.device_id else self.contact.to_s end
    end
    
    def cusses
        num_cusses = 0
        self.snippets.where('cusses > 0').each do |s|
            num_cusses += s.cusses
        end
        return num_cusses
    end
    
    def vulgarity
        percent = self.snippets.where('cusses > 0').count / Float(self.snippets.count)
        return "%.2f" % percent
    end
    
    def keystrokes
        num_keystrokes = 0
        self.snippets.each do |s|
            num_keystrokes += s.text.size
        end
        return num_keystrokes
    end
    
    def guardian
        guardians = self.contacts.where(family: true)
        puts "#{guardians.count} GUARDIANS"
        Contact.relations.each do |r|
            guardians.each do |g|
                if g.nickname.downcase == r then return g end
            end
        end
        return nil
    end

end