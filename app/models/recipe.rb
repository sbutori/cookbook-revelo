class Recipe < ApplicationRecord
  belongs_to :recipe_type
  belongs_to :cuisine

  has_many :recipe_list_items
  has_many :recipe_lists, through: :recipe_list_items

  has_one_attached :picture

  validates :title, :recipe_type, :cuisine, 
  :difficulty, :cook_time, :ingredients, :cook_method, :picture, presence: true

  def cook_time_min
    "#{cook_time} minutos" 
  end
end
