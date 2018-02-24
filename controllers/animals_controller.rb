require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/animal.rb')

get '/rescue_center/animals/all' do
  @animals = Animal.find_all()
  erb(:"animals/all")
end

get '/rescue_center/animals/new' do
  erb(:"animals/new")
end

get '/rescue_center/animals/update' do
  erb(:"animals/update")
end

get '/rescue_center/animals/rehome' do
  erb(:"animals/rehome")
end
