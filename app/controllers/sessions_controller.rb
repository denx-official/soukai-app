class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
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