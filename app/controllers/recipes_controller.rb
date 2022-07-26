class RecipesController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = User.find(params[:user_id])
    @recipes = @user.recipes
    render :index, locals: { recipes: @recipes }
  end

  def show; end

  def new
    @recipe = Recipe.new
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

  private

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public, :user_id)
  end
end
