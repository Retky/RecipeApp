class RecipesController < ApplicationController
  def index; end

  def show; end
  
  def new
    @user = current_user
    @recipe = Recipe.new
    render :new, locals: { recipe: @recipe }
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @user = current_user
    if @recipe.save
      flash[:notice] = "Recipe successfully created!"
      redirect_to user_recipe_path(@user, @recipe)
    else
      render :new, locals: { recipe: @recipe }
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public, :user_id)
  end
end
