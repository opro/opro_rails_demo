class OauthWalkthroughController < ApplicationController
  include Wicked::Wizard

  steps :create_app, :grant_access, :get_access_token, :use_access_token
  before_filter :authenticate_user!

  def index

  end

  def show
    @client_apps = Opro::Oauth::ClientApp.where(:user_id => current_user.id)
    @client_app  = @client_apps.where(:app_id => params[:client_id]).first if params[:client_id].present?
    @client_app  ||= @client_apps.try(:first)

    if params[:id] == 'use_access_token'
      @token = params[:token]
      @token ||= Opro::Oauth::AuthGrant.where(:user_id => current_user.id, :application_id => @client_app.id).first.access_token
    end
    render "oauth_walkthrough/#{params[:id]}"
  end

end
