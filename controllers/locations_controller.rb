require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/location.rb')


get '/rescue_center/locations/all' do
  @locations = Location.find_all()
  erb(:"locations/all")
end

get '/rescue_center/locations/new' do
  erb(:"locations/new")
end

post '/rescue_center/locations/new' do
  @location = Location.new(params)
  @location.save()
  erb(:"locations/confirm_added")
end

get '/rescue_center/locations/each/:id' do
  @location = Location.find_id(params['id'])
  erb(:"locations/each")
end

get '/rescue_center/locations/delete/:id' do
  @location = Location.find_id(params['id'])
  @location.delete()
  erb(:"locations/confirm_deleted")
end

get '/rescue_center/locations/update' do
  erb(:"locations/update")
end
