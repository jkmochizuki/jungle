class SessionsController < ApplicationController

  def new
  end

  def create
    if email_and_password?
      user = User.find_by_email(params[:email])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect_to root_path
      else
        flash.now.alert = "Incorrect email or password."
        render :new
      end
    else
      flash.now.alert = "Please provide a valid email and password."
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  def email_and_password?
    email = params[:email]
    password = params[:password]
    email.present? && password.present?
  end

end