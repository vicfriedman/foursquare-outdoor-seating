require 'bundler' #require bundler
Bundler.require
require 'httparty'

class MyApp < Sinatra::Base

  get '/' do
    erb :outdoor
  end

  post '/results' do
    erb :results
  end

end