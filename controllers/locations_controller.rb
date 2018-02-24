require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/location.rb')


get '/rescue_center/locations/all' do
  @locations = Location.find_all()
  erb(:"animals/all")
end

get '/rescue_center/locations/new' do
  erb(:"locations/new")
end

get '/rescue_center/locations/update' do
  erb(:"locations/update")
end
