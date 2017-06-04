class UsersController < ApplicationController
  include Common
  before_action :logged_in_user, only: [:index, :show, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: [:destroy]
  before_action :set_entrance_year, only: [:new, :edit, :create, :update]
  before_action :set_open_year, only: [:show]
  before_action :set_remind_event_category_ids, only: [:new, :edit, :create, :update]
  
  def index
    @users = User.paginate(page: params[:page], per_page: 15).where(activated: true).order("entrance_year desc, id asc")
    @year = (2006..Date.today.year).to_a.reverse
    @soukais = Soukai.narrow_year(Date.today.year).order("date asc")
    
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
    if @user.save
      @user.send_activation_email
      flash[:info] = "確認メールを送信しました。"
      redirect_to root_url
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    if params[:remind_event_category_ids].present?
      remind_event_category_ids = params[:remind_event_category_ids].map(&:to_i)
      user_remind_event_category_ids = User::RemindEventCategory.where(user_id: params[:id], event_category_id: remind_event_category_ids)
      remind_event_category_ids.each do |category_id|
        if user_remind_event_category_id = user_remind_event_category_ids.find {|u_category_id| u_category_id == category_id }
          user_remind_event_category_id.is_remind = true
          user_remind_event_category_id.save
        else
          User::RemindEventCategory.create(user_id: params[:id], event_category_id: category_id, is_remind: true)
        end
      end
    end
    
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
  
    private
    
      def user_params
        params.require(:user).permit(:name, :email, :entrance_year, :password, :password_confirmation)
      end
      
      def set_entrance_year
        @entrance_years = (Date.today.year-10..Date.today.year).to_a.reverse
      end
      
      def set_open_year
        @open_year = (2016..Date.today.year).to_a.reverse
      end
      
      def set_remind_event_category_ids
        @remind_event_category_ids = User::RemindEventCategory.where(user_id: params[:id]).map(&:event_category_id)
      end
        
end
