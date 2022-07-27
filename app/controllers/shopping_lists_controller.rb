class ShoppingListsController < ApplicationController
  before_action :authenticate_user!

  def index
    redirect_to user_shopping_lists_path(current_user) unless User.find(params[:user_id]) == current_user
    @user = current_user
    @recipes = Recipe.where(user_id: @user.id)
    @food_items = RecipeFood.joins(:food, :recipe).select(
      'foods.name as food_name, foods.measurement_unit, foods.quantity as current_quantity,
      foods.price, recipes.name as recipe_name, recipe_foods.quantity as recipe_quantity'
    ).all
    @count = 0
    @food_items.each do |item|
      @count += (item.price * item.recipe_quantity)
    end

    @total_price = total_price
  end

  def total_price
    @total_price = 0
    @recipes.each do |recipe|
      @total_price += recipe.total_price
    end
    @user.foods.each do |food|
      next unless @food_items.find_by(food_id: food.id)

      @total_price -= if food.quantity <= @food_items.find_by(food_id: food.id).recipe_quantity
                        (food.price * food.quantity)
                      else
                        food.price * @food_items.find_by(food_id: food.id).recipe_quantity
                      end
    end
    @total_price
  end
end
