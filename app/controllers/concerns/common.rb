module Common
  extend ActiveSupport::Concern
      
  # beforeフィルター

  # ログイン済みユーザーかどうか確認
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end
      
  # 正しいユーザーかどうか確認
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
    
  # 管理者かどうか確認
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
  
  def attend?(user, soukai)
    Attendance.where(user_id: user, soukai_id: soukai).present?
  end
  
  def select_layout
    "application_mobile" if request.from_smartphone?
  end

end