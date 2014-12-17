require 'bundler' #require bundler
Bundler.require
require 'httparty'
require_relative 'lib/outdoor.rb'

class MyApp < Sinatra::Base

  get '/' do
    erb :outdoor
  end

  post '/results' do
    @restuarants = Neighborhood.new(params[:neighborhood] + ", New York, NY", "VYJTGNTSNT1OHG0AURLNS0DVXPS5GKBMSW0QBKFFAFK3NMAU", "KXSEM1VPP4MXSEWX1UZCLMHONDUF5CLAHH2G4CFZUOBL1NUD")
    @restuarants.search
    @restuarants.venue_ids
    @results = @restuarants.check_outdoor
    erb :results
  end

end