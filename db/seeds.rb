require 'open-uri'
require 'json'

# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts 'Cleaning DB...'
Ingredient.destroy_all
puts 'Seeding DB...'

Ingredient.create(name: "lemon")
Ingredient.create(name: "ice")
Ingredient.create(name: "mint leaves")

# Cocktail.create(name: 'Mojito')
# Cocktail.create(name: 'Caipirinha')
# Cocktail.create(name: 'Long Island Iced Tea')
# Cocktail.create(name: 'Gin and Tonic')
# Cocktail.create(name: 'Cosmopolitan')

url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'

ingredients = JSON.parse(open(url).read)

ingredients['drinks'].each do |ingredient|
  Ingredient.create(name: ingredient.values.first)
end

cocktails = ['Mojito', 'Caipirinha', 'Long Island Iced Tea', 'Sex on the Beach', 'Gin and Tonic', 'Cosmopolitan', 'Sangria', 'Margarita', 'Michelada', 'Rum and Coke', 'Blushing Geisha', 'Bourbon Tea', 'Coconut Martini', 'Cuba Libre', 'Martini']
doses = ['1 shot', '2 shots']

cocktails.each do |cocktail|
  new_cocktail = Cocktail.create(name: cocktail)
puts new_cocktail
  3.times do
    new_dose = Dose.new(description: doses.sample)
    new_dose.cocktail = new_cocktail
    new_dose.ingredient = Ingredient.all.sample
    new_dose.save
  end
end

puts 'Done! :D'
