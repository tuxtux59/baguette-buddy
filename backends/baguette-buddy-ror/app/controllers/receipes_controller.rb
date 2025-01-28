class ReceipesController < ApplicationController
  before_action :set_receipe, only: %i[ show edit update destroy ]

  # GET /receipes
  def index
    @receipes = Receipe.all
  end

  # GET /receipes/1
  def show
  end

  # GET /receipes/new
  def new
    @receipe = Receipe.new
    @users = User.all.collect{|u| [u.username, u.id]}
  end

  # GET /receipes/1/edit
  def edit
  end

  # POST /receipes
  def create
    @receipe = Receipe.new(receipe_params)
    if receipe_params[:illustration]
      @receipe.illustration = optimize_illustration(receipe_params[:illustration].path)
    end

    if @receipe.save
      redirect_to @receipe, notice: "Receipe was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /receipes/1
  def update
    if receipe_params[:illustration]
      @receipe.illustration = optimize_illustration(receipe_params[:illustration].path)
    end

    if @receipe.update(receipe_params.reject{|k, _| k.in?([:illustration, 'illustration'])})
      redirect_to @receipe, notice: "Receipe was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /receipes/1
  def destroy
    @receipe.destroy!

    respond_to do |format|
      format.html { redirect_to receipes_path, status: :see_other, notice: "Receipe was successfully destroyed." }
    end
  end

  def base64_content(receipe)
    Base64.encode64(receipe.illustration.to_s)
  end

  private
    # Allow fetching receipe either by id or slug
    def set_receipe
      identifier = params[:id]
      if identifier.to_s.match /^\h{8}-(\h{4}-){3}\h{12}$/
        @receipe = Receipe.find(identifier)
      else
        @receipe = Receipe.find_by(slug: identifier)
      end
    end

    def receipe_params
      params.require(:receipe).permit(:title, :description, :user_id, :portions_number, :illustration)
    end
end
