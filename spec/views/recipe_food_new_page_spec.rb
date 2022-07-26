require 'rails_helper'
require 'capybara/rspec'

RSpec.describe 'Recipe food details page', type: :system do
  describe 'new page' do
    before :each do
      @user = User.new(name: 'juan', email: 'juan@hotmail.com', password: '123456')
      @user.skip_confirmation!
      @user.save!
      @food1 = Food.create(name: 'apple', measurement_unit: 'pz', price: 1.0, quantity: 1, user: @user)
      @recipe1 = Recipe.create(name: 'apple pie', preparation_time: 1.5, cooking_time: 1.0, description: 'apple pie',
                               public: true, user: @user)
      @recipe_food1 = RecipeFood.create(food: @food1, recipe: @recipe1, quantity: 1)
      visit user_recipe_path(@user, @recipe1)
      fill_in 'Email', with: 'juan@hotmail.com'
      fill_in 'Password', with: '123456'
      click_button 'Log in'
      click_link 'Add Ingredient'
      # new_user_recipe_recipe_food_path(@user, @recipe1)
      # fill_in 'Email', with: 'juan@hotmail.com'
      # fill_in 'Password', with: '123456'
      # click_button 'Log in'
    end

    it 'Shows the nav bar' do
      expect(page).to have_content('Shopping List')
    end

    it 'Shows the Add Ingredient title' do
      expect(page).to have_content('Add Ingredient')
    end

    it 'Shows the quantity label' do
      expect(page).to have_content('Quantity:')
    end

    it 'Shows the select food label' do
      expect(page).to have_content('Select Food:')
    end

    it 'Shows the add button' do
      expect(page).to have_content('Add')
    end

    it 'Shows the add food button' do
      expect(page).to have_content('Add Food')
    end
  end
end
