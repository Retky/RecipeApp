class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods, dependent: :destroy

  validates :name, presence: true, length: { maximum: 25 }
  validates :description, presence: true, length: { maximum: 500 }
  # validate :cooking_time_must_be_positive
  # validate :preparation_time_must_be_positive
  # validate :public_must_be_boolean
  def total_price
    total_price = 0
    recipe_foods.each do |item|
      total_price += (item.food.price * item.quantity)
    end
    total_price
  end

  def total_items
    recipe_foods.count
  end
end
