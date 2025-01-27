class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:user][:email].downcase)
    if @user && @user.authenticate(params[:user][:password])
      reset_session
      session[:current_user_id] = @user.id
      redirect_to receipes_path, notice: "signed in"
    else
      flash.now[:alert] = "Incorrect credentials"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    reset_session
    redirect_to root_url
  end
end
