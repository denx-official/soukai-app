class SessionsController < ApplicationController
  include Common
  layout :select_layout
  before_action :set_domain, only: [:new2, :create]
  
  def new
  end
  
  def new2
  end

  def create
    @email = params[:session][:domain].present? ? params[:session][:email].to_s + params[:session][:domain].to_s : params[:session][:email]
    user = User.find_by(email: @email.downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_to root_url
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
  
  private
    def set_domain
      num = 1
      @domain = []
      while num < 10 do
        @domain << "@mail" + num.to_s + ".doshisha.ac.jp"
        num += 1
      end
    end
  
end