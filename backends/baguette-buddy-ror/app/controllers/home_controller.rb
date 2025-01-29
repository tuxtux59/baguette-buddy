class HomeController < ApplicationController
  def welcome
    # auto redirect if logged in
    redirect_to receipes_path if user_signed_in?
  end
end
