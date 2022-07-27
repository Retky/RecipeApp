class RecipesController < ApplicationController
  def index
    @user = current_user
    @recipes = @user.recipes
    render :index, locals: { recipes: @recipes }
  end

  def show
    @user = current_user
    # @foods = Food.all
    @food = @user.foods
    @recipe = Recipe.find(params[:id])
    @recipe_foods = @recipe.recipe_foods
    # @food = Food.find(params[:food_id])
    # @foods = @food.
  end

  def new
    @user = current_user
    @recipe = Recipe.new
    render :new, locals: { recipe: @recipe }
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @user = current_user
    if @recipe.save
      flash[:notice] = 'Recipe successfully created!'
      redirect_to user_recipes_path(@user)
    else
      render :new, locals: { recipe: @recipe }
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @user = User.find(params[:user_id])
    @recipe.destroy
    flash[:notice] = 'Recipe successfully deleted  >:'
    redirect_to user_recipes_path(@user)
  end

  def toggle_public
    @user = current_user
    @recipe = Recipe.find(params[:id])
    @recipe.toggle! :public
    redirect_to user_recipe_path(@user.id, @recipe.id)
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public, :user_id)
  end
end
