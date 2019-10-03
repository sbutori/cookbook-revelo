class CuisinesController < ApplicationController  
  def index
    @cuisines = Cuisine.all
  end

  def show
    @cuisine = Cuisine.find(params[:id])
  end
  
  def new
    @cuisine = Cuisine.new
  end

  def create
    @cuisine = Cuisine.new(recipe_type_params)
    if @cuisine.save
      redirect_to cuisines_path
    else
      render :new
    end
  end

  private

  def recipe_type_params
    params.require(:cuisine).permit(:name)
  end
end