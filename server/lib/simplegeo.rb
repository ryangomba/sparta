require 'httparty'

class SimpleGeo
    
    include HTTParty
    base_uri 'https://api.simplegeo.com'
    default_params token: 'mj47XxcahecvDgzV65eY5LZgyskn7ugt'
    format :json
    
    def self.geocode_ip(ip)
        puts "Getting geocode for IP."
        request = get('/1.0/context/ip.json', query: {
            ip: ip,
            filter: 'query'
        })
        if request.response.class == Net::HTTPOK && q = request.parsed_response['query']
            lat = q['latitude']
            lon = q['longitude']
            if lat && lon then return lat, lon end
        end
        return nil, nil
    end
    
end
