class PasswordResetsController < ApplicationController
  include Common
  layout        :select_layout
  before_action :get_user,   only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]
  
  def new
  end
  
  def create
    # @user = User.find_by(email: params[:password_reset][:email].downcase)
    # if @user
    #   @user.create_reset_digest
    #   @user.send_password_reset_email
    #   flash[:info] = "パスワードリセット用のメールを送信しました"
    #   redirect_to root_url
    # else
    #   flash.now[:danger] = "メールアドレスが見つかりません(登録されてません)"
    #   render 'new'
    # end
    flash[:info] = "パスワードリセット機能は現在利用できません"
    redirect_to root_url
  end

  def edit
  end
  
  def update
    if params[:user][:password].empty?
      @user.errors.add(:password,  "can't be empty")
      render 'edit'
    elsif @user.update_attributes(user_params)
      log_in @user
      flash[:success] = "Password has been reset."
      redirect_to @user
    else
      render 'edit'
    end
  end
  
    private
    
    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    def get_user
      @user = User.find_by(email: params[:email])
    end

    # 正しいユーザーを確認する 
    def valid_user
      unless (@user && @user.activated? &&
              @user.authenticated?(:reset, params[:id]))
        redirect_to root_url
      end
    end
    
    # 再設定用トークンが期限切れかどうかを確認する
    def check_expiration
      if @user.password_reset_expired?
        flash[:danger] = "Password reset has expired."
        redirect_to new_password_reset_url
      end
    end
    
end
