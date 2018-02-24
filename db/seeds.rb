require_relative( "../models/animal.rb" )
require_relative( "../models/location.rb" )
require("pry-byebug")

Animal.delete_all()
Location.delete_all()

location1 = Location.new(
  "name" => "Rescue Center")

location1.save()

animal1 = Animal.new(
  "name" => "Steve",
  "species" => "Duck",
  "admission_date" => "2018/01/10",
  "progress" => 70,
  "location_id" => location1.id())

animal2 = Animal.new(
  "name" => "Brian",
  "species" => "Squirrel",
  "admission_date" => "2018/02/14",
  "progress" => 95,
  "location_id" => location1.id())

animal1.save()
animal2.save()
