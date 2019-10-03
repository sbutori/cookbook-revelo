class CreateRecipeListItems < ActiveRecord::Migration[5.2]
  def change
    create_table :recipe_list_items do |t|
      t.references :recipe, foreign_key: true
      t.references :recipelist, foreign_key: true

      t.timestamps
    end
  end
end
