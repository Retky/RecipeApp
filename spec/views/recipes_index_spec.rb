require 'rails_helper'
require 'capybara/rspec'

RSpec.describe 'Food index page', type: :feature do
  describe 'index page' do
    before :each do
      @user = User.new(name: 'retky', email: 'retky@test.com', password: '123456')
      @user.skip_confirmation!
      @user.save!
      @recipe = Recipe.new(name: 'Pizza', description: 'A delicious pizza', user_id: @user.id).save
      @recipe2 = Recipe.new(name: 'Apple Pie', description: 'A delicious apple pie', user_id: @user.id).save
      @recipe3 = Recipe.new(name: 'Orange Chicken', description: 'A popular Chinese dish', user_id: @user.id).save
      visit user_recipes_path(@user)
      fill_in 'Email', with: 'retky@test.com'
      fill_in 'Password', with: '123456'
      click_button 'Log in'
    end

    it 'should show the navbar' do
      expect(page).to have_content('Recipe App')
      expect(page).to have_content('Food')
      expect(page).to have_content('Shopping List')
      expect(page).to have_content('Log Out')
    end

    it 'should have a button to add a new recipes' do
      expect(page).to have_button('New Recipe')
    end

    it 'should show a list of recipes' do
      expect(page).to have_content('Pizza')
      expect(page).to have_content('Apple Pie')
      expect(page).to have_content('Orange Chicken')
    end

    it 'should show the description of each recipe' do
      expect(page).to have_content('A delicious pizza')
      expect(page).to have_content('A delicious apple pie')
      expect(page).to have_content('A popular Chinese dish')
    end

    it 'should show a remove button for each recipe' do
      expect(page).to have_button('Remove')
    end

    it 'should redirect to the recipe show page when a recipe is clicked' do
      click_link 'Pizza'
      expect(page).to have_content('Pizza')
      expect(page).to have_content('Preparation time:')
      expect(page).to have_content('Cooking time:')
    end
  end
end
