class Api::ReceipesController < ApplicationController
  before_action :set_receipe, only: %i[ show update destroy ]
  skip_before_action :verify_authenticity_token

  # GET /api/recipes
  def index
    @receipes = Receipe.all
  end

  # GET /api/recipes/1
  def show
  end

  # POST /api/recipes
  def create
    @receipe = Receipe.new(receipe_params)
    if receipe_params[:illustration]
      @receipe.illustration = optimize_illustration(receipe_params[:illustration].path)
    end

    if @receipe.save
      render :show, status: :created, location: @receipe
    else
      render json: @receipe.errors, status: :unprocessable_entity
    end
  end
  
  # PUT/PATCH /api/recipes/:id
  def update
    if receipe_params[:illustration]
      @receipe.illustration = optimize_illustration(receipe_params[:illustration].path)
    end

    if @receipe.update(receipe_params.reject{|k, _| k.in?([:illustration, "illustration"])})
      render :show, status: :ok, location: @receipe
    else
      render json: @receipe.errors, status: :unprocessable_entity
    end
  end
  
  # DELETE /api/recipes/:id
  def destroy
    @receipe.destroy!

    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private

  def set_receipe
    @receipe = Receipe.find(params[:id])
  end

  def receipe_params
    params.require(:receipe).permit(:title, :description, :user_id, :portions_number, :illustration)
  end
end
