class RecipeTypesController < ApplicationController  
  def index
    @recipe_types = RecipeType.all
  end
  
  def new
    @recipe_type = RecipeType.new
  end

  def create
    @recipe_type = RecipeType.new(recipe_type_params)
    if @recipe_type.save
      redirect_to recipe_types_path
    else
      flash.now[:warning] = 'Você deve informar todos os dados da receita'
      render :new
    end
  end

  private

  def recipe_type_params
    params.require(:recipe_type).permit(:name)
  end
end