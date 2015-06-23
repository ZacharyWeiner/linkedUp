class UsersController < ApplicationController
  before_action :set_user
  def show
  end

  def index 
 	@users = User.all
  end 

  private 
  def set_user
  	@user = User.find_by(username: params[:id])
  end
end
