class SessionsController < ApplicationController
  
  def new
    num = 1
    @domain = []
    while num < 10 do
      @domain << "@mail" + num.to_s + ".doshisha.ac.jp"
      num += 1
    end
  end

  def create
    email = params[:email] + params[:domain]
    user = User.find_by(email: email)
    if user && user.authenticate(params[:password])
      if user.activated?
        log_in user
        params[:remember_me] == '1' ? remember(user) : forget(user)
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