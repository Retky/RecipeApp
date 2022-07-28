class RecipeFoodsController < ApplicationController
  def new
    @recipe_food = RecipeFood.new
  end

  def create
    @user = current_user
    @recipe = @user.recipes.find(params[:recipe_id])
    @food = @user.foods.find_by(id: recipe_food_params[:food_id])
    @recipe_food = @recipe.recipe_foods.new(recipe_food_params)
    @recipe_food.recipe_id = @recipe.id
    @recipe_food.food_id = @food.id
    if @recipe_food.save && user_signed_in?
      flash[:notice] = 'Recipe food successfully created!'
      redirect_to user_recipe_path(current_user, @recipe)
    else
      flash[:notice] = 'Recipe food not created!'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @user = current_user
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = RecipeFood.find(params[:id])
    @recipe_food.destroy
    redirect_to user_recipe_path(@user.id, @recipe.id)
  end

  def edit
    @recipe_food = RecipeFood.find(params[:id])
  end

  def update
    @user = current_user
    @recipe_food = RecipeFood.find(params[:id])
    @recipe = Recipe.find(@recipe_food.recipe_id)
    @recipe_food.update(quantity: params[:recipe_food][:quantity])
    redirect_to user_recipe_path(current_user, @recipe)
  end

  private

  def recipe_food_params
    params.require(:recipe_food).permit(:food_id, :quantity)
  end

  def recipe_food_modify_params
    params.require(:recipe_food).permit(:quantity)
  end
end
