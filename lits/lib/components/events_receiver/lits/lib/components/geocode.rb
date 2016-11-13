require 'json'
require 'net/http'

module Components
  class Geocode
    def self.get_coordinates_by_address(address)
      enc_address = URI.encode(address)
      uri = URI("https://maps.googleapis.com/maps/api/geocode/json?address=#{enc_address}")
      hash = JSON.parse(Net::HTTP.get(uri))
      geo = if hash['status'] == 'OK'
              hash['results'][0]['geometry']['location']
            else
              { 'lat' => 0, 'lng' => 0 }
            end
      return geo['lat'], geo['lng']
    end
  end
end
