class UsersController < ApplicationController

  before_filter :authenticate_user!

  allow_oauth! :except => :delete

  def show
    @user =   current_user if params[:id] == 'me'
    @user ||= User.find(params[:id])
    respond_to do |format|
      format.html
      format.json do
        # User#to_public_json will remove sensitive elements from the user object
        render :json => @user.to_public_json
      end
    end
  end

  def update
    @user = current_user
    @user.update_attributes(params[:user])
    respond_to do |format|
      format.json do
        render :json => @user.to_public_json
      end
      format.html do
        render :edit
      end
    end
  end

  def delete
    @user = current_user
    @user.destroy
    redirect_to root_path
  end
end
