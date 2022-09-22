require 'cgi'
require 'cuss'
require 'simplegeo'

class Snippet < ActiveRecord::Base
    default_scope limit(50).order('created_at DESC')

    belongs_to :user
    validates_presence_of :text
    
    def escaped_text
        CGI::escapeHTML(self.text)
    end
    
    def html
        return markup(self.escaped_text).html_safe
    end
    
    def location_link
        if self.latitude && self.longitude
            return "http://maps.google.com/maps?q=#{self.latitude},+#{self.longitude}"
        else
            return nil
        end
    end
    
    before_save :geocode, :score
    
    def geocode
        if this_ip = Ip.find_by_address(self.ip)
            puts 'Using "cached" IP'
            self.latitude = this_ip.latitude
            self.longitude = this_ip.longitude
        else
            self.latitude, self.longitude = SimpleGeo.geocode_ip(self.ip)
            Ip.create(
                address: self.ip,
                latitude: self.latitude,
                longitude: self.longitude
            )
        end
    end
    
    def score
        self.cusses = find_cusses(self.text).size
    end
    
    after_create :phone_home
    
    def phone_home
        if self.cusses > 0 then (Delayed::Job.enqueue self) end
    end
    
    def perform
        if relation = self.user.guardian
            user = self.user
            msg = self.text
            UserMailer.report(user, relation, msg).deliver
        else
            puts "NO GUARDIAN"
        end
    end

end