require 'rails_helper'
require 'capybara/rspec'

RSpec.describe 'Food index page', type: :system do
  describe 'index page' do
    before :each do
        @user = User.new(name: "juan", email: "juan@hotmail.com", password: "123456")
        @user.skip_confirmation!
        @user.save!
        @food1 = Food.create(name: "apple", measurement_unit: "pz", price: 1.0, quantity: 1, user: @user)
        visit user_foods_path(@user)
        fill_in 'Email', with: 'juan@hotmail.com'
        fill_in 'Password', with: '123456'
        click_button 'Log in'
    end

    it 'Shows the nav bar' do
      expect(page).to have_content('Shopping List')
    end

    it 'Shows the Food text' do
      expect(page).to have_content('Food')
    end

    it 'Shows unit price value' do
      expect(page).to have_content('$ 1.0')
    end

    it 'Shows the add food button' do
      expect(page).to have_content('Add Food')
    end

    it 'Shows the delete button' do
      expect(page).to have_content('Delete')
    end

    it 'Redirects to the add food page when clicking on the Add Food button' do
      click_link 'Add Food'
      expect(current_path).to eq(new_user_food_path(@user))
    end
  end
end