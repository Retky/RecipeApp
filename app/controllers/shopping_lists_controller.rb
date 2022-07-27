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
  end
end
