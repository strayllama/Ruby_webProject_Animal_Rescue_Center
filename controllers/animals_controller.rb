require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/animal.rb')
require_relative('../models/location.rb')
require_relative('../models/terrain_type.rb')
require('pry-byebug')

get '/rescue_center/animals/all' do
  @animals = Animal.find_all()
  erb(:"animals/all")
end

get '/rescue_center/animals/all_by_species' do
  @animals = Animal.find_all_sort_species()
  erb(:"animals/all_by_species")
end

get '/rescue_center/animals/all_by_sex' do
  @animals = Animal.find_all_sort_sex()
  erb(:"animals/all_by_sex")
end

get '/rescue_center/animals/all_by_type' do
  @animals = Animal.find_all_sort_type()
  erb(:"animals/all_by_type")
end


get '/rescue_center/animals/new' do
  @terrain_types = Terrain_type.find_all()
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
  @terrain_types = Terrain_type.find_all()
  erb(:"animals/update")
end

post '/rescue_center/animals/update/:id' do
  @animal = Animal.new(params)
  @animal.update()
  erb(:"animals/confirm_updated")
end

get '/rescue_center/animals/rehome/:id' do
  @animal = Animal.find_id(params['id'])
  @terrain_types = Terrain_type.find_all()
  @suitable_locations = @animal.suitable_locations()
  erb(:"animals/rehome")
end

post '/rescue_center/animals/rehome' do
  @animal = Animal.find_id(params['id'].to_i)
  @animal.change_location_id(params['location_id'])
  @animal.update()
  erb(:"animals/confirm_rehomed")
end
