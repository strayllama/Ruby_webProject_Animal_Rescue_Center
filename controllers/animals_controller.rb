require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/animal.rb')
require_relative('../models/location.rb')

get '/rescue_center/animals/all' do
  @animals = Animal.find_all()
  erb(:"animals/all")
end

get '/rescue_center/animals/new' do
  erb(:"animals/new")
end

post '/rescue_center/animals/new' do
  @animal = Animal.new(params)
  @animal.save()
  erb(:"animals/confirm_added")
end

get '/rescue_center/animals/each/:id' do
  @animal = Animal.find_id(params['id'])
  erb(:"animals/each")
end

get '/rescue_center/animals/check_delete/:id' do
  @animal = Animal.find_id(params['id'])
  erb(:"animals/check_delete")
end

get '/rescue_center/animals/delete/:id' do
  @animal = Animal.find_id(params['id'])
  @animal.delete()
  erb(:"animals/confirm_deleted")
end

get '/rescue_center/animals/update/:id' do
  @animal = Animal.find_id(params['id'])
  erb(:"animals/update")
end

get '/rescue_center/animals/rehome/:id' do
  @animal = Animal.find_id(params['id'])
  @locations = Location.find_all()
  erb(:"animals/rehome")
end

post '/rescue_center/animals/rehome' do
  @animal = Animal.find_id(params['id'].to_i)
  @animal.change_location_id(params['location_id'])
  @animal.update()
  erb(:"animals/rehome_confirm")
end
