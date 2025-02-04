class Api::IngredientsController < ApplicationController
  before_action :set_ingredients, only: %i[ show update destroy ]
  skip_before_action :verify_authenticity_token #, only: [:create]

  # GET /api/recipes
  def index
    @ingredients = Ingredient.all
  end

  # GET /api/recipes/1
  def show
  end

  # POST /api/recipes
  def create
    @ingredients = Ingredient.new(ingredients_params)
    if ingredients_params[:illustration]
      @ingredients.illustration = optimize_illustration(ingredients_params[:illustration].path)
    end

    if @ingredients.save
      render :show, status: :created, location: @ingredients
    else
      render json: @ingredients.errors, status: :unprocessable_entity
    end
  end
  
  # PUT/PATCH /api/recipes/:id
  def update
    if ingredients_params[:illustration]
      @ingredients.illustration = optimize_illustration(ingredients_params[:illustration].path)
    end

    if @ingredients.update(ingredients_params.reject{|k, _| k.in?([:illustration, "illustration"])})
      render :show, status: :ok, location: @ingredients
    else
      render json: @ingredients.errors, status: :unprocessable_entity
    end
  end
  
  # DELETE /api/recipes/:id
  def destroy
    @ingredients.destroy!

    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private

  def set_ingredients
    @ingredients = Ingredient.find(params[:id])
  end

  def ingredients_params
    params.require(:ingredients).permit(:title, :description, :user_id, :portions_number, :illustration)
  end
end
