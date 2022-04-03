class UsersController < ApplicationController
  include Common
  before_action :logged_in_user, only: [:index, :show, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: [:destroy, :to_admin]
  before_action :set_entrance_year, only: [:new, :edit, :create, :update]
  before_action :set_open_year, only: [:show]
  
  def index
    @users = User.paginate(page: params[:page], per_page: 15).where(activated: true).order("entrance_year desc, id asc")
    @year = (2006..Date.today.year).to_a.reverse
    soukai_year = params[:soukai_year].present? ? params[:soukai_year].to_i : Date.today.year
    @soukais = Soukai.narrow_year(soukai_year).order("date asc")
    
    if params[:name].present?
      @users = @users.where(['name LIKE ?', "%#{params[:name]}%"])
    end
    if params[:year].present?
      @users = @users.where(entrance_year: params[:year])
    end
    if params[:soukai_id].present?
      attendance = Attendance.where(soukai_id: params[:soukai_id]).map(&:user_id)
      @users = @users.where(id: attendance)
    end
  end
  
  def show
    @user = User.find(params[:id])
    open_year = params[:open_year].present? ? params[:open_year].to_i : Date.today.year
    @soukais = Soukai.narrow_year(open_year).order("date asc")
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if !is_valid_invitation_code
      flash[:danger] = "招待コードが違います"
      render 'new'
    elsif @user.save
      @user.activate
      log_in @user
      flash[:info] = "アカウントを作成しました。"
      redirect_to root_url
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "変更されました"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end
  
  def change_admin
    @user = User.find(params[:id])
    if @user.update(admin: params[:admin])
      flash[:success] = "変更されました"
    else
      flash[:danger] = "失敗"
    end
      redirect_to @user
  end
  
    private
    
      def user_params
        params.require(:user).permit(:name, :email, :entrance_year, :password, :password_confirmation)
      end

      def is_valid_invitation_code
        code = params.require(:user).permit(:invitation_code)['invitation_code']
        BCrypt::Password::new(ENV["INVITATION_CODE"]) == code
      end
      
      def set_entrance_year
        @entrance_years = (Date.today.year-10..Date.today.year).to_a.reverse
      end
      
      def set_open_year
        @open_year = (2016..Date.today.year).to_a.reverse
      end
        
end
