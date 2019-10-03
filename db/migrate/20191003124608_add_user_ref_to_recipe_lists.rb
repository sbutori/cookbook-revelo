class AddUserRefToRecipeLists < ActiveRecord::Migration[5.2]
  def change
    add_reference :recipe_lists, :user, foreign_key: true
  end
end
