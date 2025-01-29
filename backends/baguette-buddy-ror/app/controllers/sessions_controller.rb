class SessionsController < ApplicationController
  def new
  end

  def create
    @user = find_user(params)
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

  private

  def find_user(params)
    email_or_username = params[:user][:email_or_username].strip
    puts email_or_username
    if email_or_username.match?(URI::MailTo::EMAIL_REGEXP)
      @user = User.find_by(email: email_or_username.downcase)
    else
      @user = User.find_by(username: email_or_username)
    end
  end
end
