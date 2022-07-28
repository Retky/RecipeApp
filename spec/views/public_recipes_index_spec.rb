require 'rails_helper'
require 'capybara/rspec'

RSpec.describe 'Food index page', type: :feature do
  describe 'index page' do
    before :each do
      @user = User.new(name: 'retky', email: 'retky@test.com', password: '123456')
      @user.skip_confirmation!
      @user.save!
      @recipe = Recipe.new(name: 'Pizza', description: 'A delicious pizza', user_id: @user.id, public: true).save
      @recipe2 = Recipe.new(name: 'Apple Pie', description: 'A delicious apple pie', user_id: @user.id).save
      @recipe3 = Recipe.new(name: 'Orange Chicken', description: 'A popular Chinese dish', user_id: @user.id, public: true).save
      visit new_user_session_path
      fill_in 'Email', with: 'retky@test.com'
      fill_in 'Password', with: '123456'
      click_button 'Log in'
      visit public_recipes_path
    end

    it 'should show the navbar' do
      expect(page).to have_content('Recipe App')
      expect(page).to have_content('Food')
      expect(page).to have_content('Shopping List')
      expect(page).to have_content('Log Out')
    end

    it 'should be accessible by anyone' do
      click_link 'Log Out'
      expect(page).to have_content('Recipe App')
      expect(page).to have_content('Public Recipes')
    end

    it 'should only show public recipes' do
      expect(page).to have_content('Pizza')
      expect(page).to_not have_content('Apple Pie')
      expect(page).to have_content('Orange Chicken')
    end

    it 'should show the author of each recipe' do
      expect(page).to have_content('By retky')
    end

    it 'should show the Total food items' do
      expect(page).to have_content('Total food items:')
    end

    it 'should show the Total price' do
      expect(page).to have_content('Total price:')
    end

    it 'should redirect to the recipe show page when a recipe is clicked' do
      click_link 'Pizza'
      expect(page).to have_content('Pizza')
      expect(page).to have_content('Preparation time:')
      expect(page).to have_content('Cooking time:')
    end
  end
end
