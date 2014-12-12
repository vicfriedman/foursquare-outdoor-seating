require 'bundler' #require bundler
Bundler.require
require 'httparty'
require_relative 'lib/outdoor.rb'

class MyApp < Sinatra::Base

  get '/' do
    erb :outdoor
  end

  post '/results' do
    @restuarants = Neighborhood.new(params[:neighborhood] + ", New York, NY")
    @restuarants.search
    @restuarants.venue_ids
    @results = @restuarants.check_outdoor
    erb :results
  end

end