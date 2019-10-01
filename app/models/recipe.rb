class Recipe < ApplicationRecord
  belongs_to :recipe_type
  has_one_attached :picture

  validates :title, :recipe_type, :cuisine, 
  :difficulty, :cook_time, :ingredients, :cook_method, :picture, presence: true

  def cook_time_min
    "#{cook_time} minutos" 
  end

  HUMANIZED_ATTRIBUTES = {
    :title => "Título",
    :recipe_type => "Tipo da Receita",
    :cuisine => "Cozinha",
    :difficulty => "Dificuldade", 
    :cook_time => "Tempo de Cozimento", 
    :ingredients => "Ingredientes", 
    :cook_method => "Método de Preparo"
  }

  def self.human_attribute_name(attr, options = {})
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end
end
