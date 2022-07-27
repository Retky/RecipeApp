class RecipeFoodsController < ApplicationController
  def new
    @recipe_food = RecipeFood.new
    # render :new, locals: { recipe_food: @recipe_food, recipe: @recipe }
  end

  def create
    @user = current_user
    @food = Food.find_by(id: recipe_food_params[:food_id])
    # @recipe = Recipe.find_by(id: recipe_food_params[:recipe_id])
    # @recipe = Recipe.find_by(id: params[:recipe_id])
    @recipe_food = RecipeFood.new(food_id: @food, quantity: recipe_food_params[:quantity], recipe_id: recipe_food_params[:recipe_id])
    # @recipe_food.recipe_id = @recipe.id
    if @recipe_food.save
      flash[:notice] = 'Recipe food successfully created!'
      redirect_to user_recipe_path(current_user, @recipe)
    else
      render :new
    end
  end
 

  def destroy
    @recipe_food = RecipeFood.find(params[:id])
    @recipe_food.destroy
    #   redirect_to user_recipe_path(@user.id, @recipe.id)
  end

  def edit
    @recipe_food = RecipeFood.find(params[:id])
  end

  def update
    @recipe_food = RecipeFood.find(params[:id])
    @recipe = Recipe.find(@recipe_food.recipe_id)
    @recipe_food.update(quantity: params[:recipe_food][:quantity])
    redirect_to user_recipe_path(current_user, @recipe)
  end

  private

  def recipe_food_params
    params.require(:recipe_food).permit(:food_id, :quantity, :recipe_id)
  end

  def recipe_food_modify_params
    params.require(:recipe_food).permit(:quantity)
  end
end
