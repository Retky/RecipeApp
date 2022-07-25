# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# Users
user1 = User.create(name: "Juan")

# Foods

food1 = Food.create(name: "apple", measurement_unit: "pz", price: 1.0, quantity: 1, user: user1)

# Recipes

recipe1 = Recipe.create(name: "apple pie", preparation_time: 1.5, cooking_time: 1.0, description: "apple pie", public: true, user: user1)
# RecipeFoods

recipe_food1 = RecipeFood.create(food: food1, recipe: recipe1, quantity: 1)
