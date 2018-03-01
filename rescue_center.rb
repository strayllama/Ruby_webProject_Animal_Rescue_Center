require('sinatra')
#require('sinatra/contrib/all')
#require('pry-byebug')
require_relative('controllers/animals_controller.rb')
require_relative('controllers/locations_controller.rb')
require_relative('models/animal.rb')

get '/rescue_center' do
  @healthy_animals = Animal.healthy()
  @ill_animals = Animal.ill()
  @terrain_types = Terrain_type.find_all()
  erb(:index)
end


#pry.binding
