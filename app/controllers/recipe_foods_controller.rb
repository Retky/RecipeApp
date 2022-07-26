class RecipeFoodsController < ApplicationController
  def new
    # @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = RecipeFood.new
    # render :new, locals: { recipe_food: @recipe_food, recipe: @recipe }
  end

  def create
    @user = current_user
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = @recipe.recipe_food.new(recipe_food_params)
    @recipe_food.recipe_id = @recipe.id
    puts @recipe_food.inspec
    if @recipe_food.save
      flash[:notice] = 'Recipe successfully created!'
      redirect_to user_recipe_path(@user.id, @recipe.id)
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
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = RecipeFood.find(params[:id])
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
