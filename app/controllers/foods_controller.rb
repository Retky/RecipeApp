class FoodsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @food = @user.foods
    redirect_to user_foods_path(current_user) unless User.find(params[:user_id]) == current_user
  end

  def new
    @food = Food.new
  end

  def create
    @food = Food.new(food_params)
    @food.user = current_user
    if @food.save
      redirect_to user_foods_path(current_user)
    else
      render :new
    end
  end

  def destroy
    @food = Food.find(params[:id])
    @food.destroy
    redirect_to foods_path
  end

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
  end
end
