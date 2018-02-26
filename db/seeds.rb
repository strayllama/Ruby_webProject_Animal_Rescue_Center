require_relative( "../models/animal.rb" )
require_relative( "../models/location.rb" )

Animal.delete_all()
Location.delete_all()

location1 = Location.new(
  "name" => "Rescue Center",
  "description" => "Well equipped animal rescue center!",
  "land" => "Yes",
  "tree_top" => "Yes",
  "aquatic" => "Yes")

location2 = Location.new(
  "name" => "Hilton Tree-tops",
  "description" => "5 STAR animal retreet! Hidden watching stations amoungst the trees. Many different tree dwelling creatures.",
  "land" => "Yes",
  "tree_top" => "Yes",
  "aquatic" => "No")

location3 = Location.new(
  "name" => "Pond life",
  "description" => "Large deep pond with large complex of island. Great place for animals to relax.",
  "land" => "Yes",
  "tree_top" => "No",
  "aquatic" => "Yes")

location1.save()
location2.save()
location3.save()

animal1 = Animal.new(
  "name" => "Steve",
  "species" => "Malard Duck",
  "admission_date" => "2018/01/10",
  "health" => 70,
  "location_id" => location1.id(),
  "age" => "Young",
  "sex" => "Male",
  "size" => "Medium",
  "colour" => "tbc")

animal2 = Animal.new(
  "name" => "Brian",
  "species" => "Gray Squirrel",
  "admission_date" => "2018/02/14",
  "health" => 95,
  "location_id" => location1.id(),
  "age" => "Old",
  "sex" => "Male",
  "size" => "Large",
  "colour" => "Gray")

animal3 = Animal.new(
  "name" => "Gill",
  "species" => "Wood Rat",
  "admission_date" => "2018/02/20",
  "health" => 5,
  "location_id" => location1.id(),
  "age" => "Old",
  "sex" => "Female",
  "size" => "Very Large",
  "colour" => "Brown")

animal4 = Animal.new(
  "name" => "Eli",
  "species" => "Wild Cat",
  "admission_date" => "2018/01/30",
  "health" => 100,
  "location_id" => location1.id(),
  "age" => "Young",
  "sex" => "Male",
  "size" => "Large",
  "colour" => "Ginger")

animal5 = Animal.new(
  "name" => "Ted",
  "species" => "Human Boy",
  "admission_date" => "2018/02/05",
  "health" => 100,
  "location_id" => location1.id(),
  "age" => "Young",
  "sex" => "Male",
  "size" => "Small",
  "colour" => "Pink")

animal6 = Animal.new(
  "name" => "Freddy",
  "species" => "Qui Carp",
  "admission_date" => "2017/11/25",
  "health" => 100,
  "location_id" => location3.id(),
  "age" => "Young",
  "sex" => "Female",
  "size" => "Small",
  "colour" => "Silver")

animal7 = Animal.new(
  "name" => "Craig",
  "species" => "Swan",
  "admission_date" => "2017/12/18",
  "health" => 100,
  "location_id" => location3.id(),
  "age" => "Elderly",
  "sex" => "Male",
  "size" => "Medium",
  "colour" => "White")

animal1.save()
animal2.save()
animal3.save()
animal4.save()
animal5.save()
animal6.save()
animal7.save()
