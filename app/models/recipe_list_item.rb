class RecipeListItem < ApplicationRecord
  belongs_to :recipe
  belongs_to :recipe_list
end
