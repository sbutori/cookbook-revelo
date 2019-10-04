class Recipe < ApplicationRecord
  belongs_to :recipe_type
  belongs_to :cuisine
  belongs_to :user

  has_many :recipe_list_items
  has_many :recipe_lists, through: :recipe_list_items

  has_one_attached :picture

  validates :title, :recipe_type_id, :cuisine_id, :user_id, 
  :difficulty, :cook_time, :ingredients, :cook_method, :picture, presence: true

  enum status: { pending: 0, approved: 1} 

  def cook_time_min
    "#{cook_time} minutos" 
  end
end
