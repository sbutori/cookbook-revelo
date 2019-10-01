class RecipeType < ApplicationRecord
  has_many :recipes
  
  validates :name, presence: true
  validates :name, uniqueness: true, on: [:create, :update]

  HUMANIZED_ATTRIBUTES = {
    :name => "Nome"
  }

  def self.human_attribute_name(attr, options = {}) # 'options' wasn't available in Rails 3, and prior versions.
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end
end
