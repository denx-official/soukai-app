class SessionsController < ApplicationController
  include Common
  layout :select_layout
  
  def new
  end
  
  def new2
    set_domain
  end

  def create
    set_domain
    if params[:session].present?
      email = params[:session][:email]
      password = params[:session][:password]
      remember_me = params[:session][:remember_me]
    else
      email = params[:email].to_s + params[:domain].to_s
      password = params[:password]
      remember_me = params[:remember_me]
    end
    
    user = User.find_by(email: email)
    if user && user.authenticate(password)
      if user.activated?
        log_in user
        remember_me == '1' ? remember(user) : forget(user)
        redirect_back_or user
      else
        message  = "アカウントが有効化されてません。"
        message += "アクティブメールを確認して、有効化リンクを踏んでください。"
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] = 'EmailかPasswordのどっちがが間違ってます'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
  
end