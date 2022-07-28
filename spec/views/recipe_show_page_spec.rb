require 'rails_helper'
require 'capybara/rspec'

RSpec.describe 'Recipe details page', type: :system do
  describe 'show page' do
    before :each do
        @user = User.new(name: "juan", email: "juan@hotmail.com", password: "123456")
        @user.skip_confirmation!
        @user.save!
        @food1 = Food.create(name: "apple", measurement_unit: "pz", price: 1.0, quantity: 1, user: @user)
        @recipe1 = Recipe.create(name: "apple pie", preparation_time: 1.5, cooking_time: 1.0, description: "apple pie", public: true, user: @user)
        @recipe_food1 = RecipeFood.create(food: @food1, recipe: @recipe1, quantity: 1)
        visit user_recipe_path(@user, @recipe1)
        fill_in 'Email', with: 'juan@hotmail.com'
        fill_in 'Password', with: '123456'
        click_button 'Log in'
    end

    it 'Shows the nav bar' do
      expect(page).to have_content('Shopping List')
    end

    it 'Shows the quantity' do
      expect(page).to have_content('1 pz')
    end

    it 'Shows the value' do
      expect(page).to have_content('$ 1.0')
    end

    it 'Shows the preparation time' do
      expect(page).to have_content('Preparation time: 1.5 hours')
    end

    it 'Shows the add ingredient button' do
      expect(page).to have_content('Add Ingredient')
    end

    it 'Shows the delete button' do
      expect(page).to have_content('Delete')
    end

    it 'Shows the modify button' do
      expect(page).to have_content('Modify')
    end

    it 'Redirects to the add ingredient page when clicking on the Add Ingredient button' do
      click_link 'Add Ingredient'
      expect(current_path).to eq(new_user_recipe_recipe_food_path(@user, @recipe1))
    end

    it 'Redirects to the modify ingredient page when clicking on the modify button' do
      click_link 'Modify'
      expect(current_path).to eq(edit_user_recipe_recipe_food_path(@user, @recipe1, @recipe_food1))
    end
  end
end