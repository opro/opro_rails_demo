class Users::RandomController < ApplicationController


  def create
    random   = User.random.gsub('.', '')
    email    = "#{random}@example.com"
    password = "password_#{random}"
    @user    = User.create(:email => email, :password => password, :password_confirmation => password)

    respond_to do |format|
      if @user.save
        sign_in(@user, :bypass => true)
        format.html { redirect_to root_url }
        format.json { render :json => {:username => email, :password => password } }
      else
        format.html { redirect_to root_url, :notice => "could not create user" }
        format.json { render :json => {:errors => @user.errors.full_messages } }
      end
    end
  end

end
