require 'HTTParty'

class Neighborhood
  CLIENT_ID = 'KXSEM1VPP4MXSEWX1UZCLMHONDUF5CLAHH2G4CFZUOBL1NUD'
  CLIENT_SECRET = 'VYJTGNTSNT1OHG0AURLNS0DVXPS5GKBMSW0QBKFFAFK3NMAU'
  
  attr_accessor :location, :venues, :outdoor_venues

  def initialize(location)
    @location = location
    @outdoor_venues = []
  end

  def search
    uri = "https://api.foursquare.com/v2/venues/explore?near=#{@location}&client_id=#{CLIENT_ID}&client_secret=#{CLIENT_SECRET}&v=#{Time.now.strftime("%Y%m%d")}&categoryId=4d4b7105d754a06374d81259"
    encoded = URI.parse(URI.encode(uri)) #to handle spaces in the location
    @venues = HTTParty.get(encoded)['response']['groups'][0]["items"]
  end

  def venue_ids
    ids = []
    @venues.each do |venue|
      ids << venue["venue"]["id"]
    end
    @venues = []
    ids.each do |i|
      @venues << HTTParty.get("https://api.foursquare.com/v2/venues/#{i}?client_id=#{CLIENT_ID}&client_secret=#{CLIENT_SECRET}&v=#{Time.now.strftime("%Y%m%d")}&m=foursquare")
    end
  end

  def check_outdoor
    @outdoor_venues = []
    @venues.each do |venue|
      venue['response']['venue']['attributes']['groups'].each do |v|
        v.each do |info_array|
          if info_array.include?("Outdoor Seating")
            @outdoor_venues << venue['response']['venue']['name']
          end
        end
      end
    end
   @outdoor_venues.uniq!
  end


end

c = Neighborhood.new("West Village, New York, NY")
c.search
c.venue_ids
c.check_outdoor
