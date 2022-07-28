require 'rails_helper'
require 'capybara/rspec'

RSpec.describe 'Food index page', type: :feature do
  describe 'index page' do
    before :each do
      @user = User.new(name: 'retky', email: 'retky@test.com', password: '123456')
      @user.skip_confirmation!
      @user.save!
      @recipe3 = Recipe.create(name: 'Orange Chicken', description: 'A popular Chinese dish', user_id: @user.id,
                               public: true)
      @food1 = Food.create(name: 'Chicken', measurement_unit: 'kg', quantity: '1', price: '15', user_id: @user.id)
      @food2 = Food.create(name: 'Orange', measurement_unit: 'pz', quantity: '1', price: '2', user_id: @user.id)
      @recipe_food1 = RecipeFood.create(recipe_id: @recipe3.id, food_id: @food1.id, quantity: '1')
      @recipe_food2 = RecipeFood.create(recipe_id: @recipe3.id, food_id: @food2.id, quantity: '4')
      visit new_user_session_path
      fill_in 'Email', with: 'retky@test.com'
      fill_in 'Password', with: '123456'
      click_button 'Log in'
      visit user_shopping_lists_path(@user)
    end

    it 'should show the navbar' do
      expect(page).to have_content('Recipe App')
      expect(page).to have_content('Food')
      expect(page).to have_content('Shopping List')
      expect(page).to have_content('Log Out')
    end

    it 'should show the title' do
      expect(page).to have_content('Shopping List')
    end

    it 'should show the Amount of food items' do
      expect(page).to have_content('Amount of food items to buy: 2')
    end

    it 'should show the Total value of food needed' do
      expect(page).to have_content('Total value of food needed: 6.0')
    end

    it 'should show the recipe name' do
      expect(page).to have_content('Orange Chicken')
    end

    it 'should show only the food items that are needed' do
      expect(page).to_not have_content('Chicken 1kg')
      expect(page).to have_content('Orange 3pz')
    end

    it 'should show the food items that are needed' do
      expect(page).to have_content('Orange 3pz')
    end

    it 'should show the price of the needed food items' do
      expect(page).to have_content('$ 6.0')
    end
  end
end
