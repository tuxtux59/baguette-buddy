class ApplicationController < ActionController::Base
  include Authenticated
  include ApplicationHelper

  before_action :authenticate_user!

  private 

  def authenticate_user!
    return if request.path.starts_with?('/api')
    
    if !request.path.in?(['/', '/login', '/sign_up']) && !user_signed_in?
      puts "path =#{request.path}"
      if request.format.html?
        redirect_to root_path, notice: "Please sign in to continue."
      elsif request.format.json?
        render json: { error: 'Unauthorized' }, status: :unauthorized
      end
    end
  end
end
