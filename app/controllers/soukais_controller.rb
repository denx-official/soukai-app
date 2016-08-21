class SoukaisController < ApplicationController
  include Common
  layout        :select_layout
  before_action :admin_user
  
  def index
    @soukais = Soukai.paginate(page: params[:page]).order("date").reverse_order
  end
  
  def show
    @soukai = Soukai.find(params[:id])
    @user = []
    Attendance.where("soukai_id = #{params[:id]}").order("user_id").each do |n|
      @user << User.find(n.user_id)
    end
  end
  
  def new
    @soukai = Soukai.new
  end
  
  def create
    @soukai = Soukai.new(soukai_params)
    if @soukai.save
      flash[:info] = "総会が登録されました"
      redirect_to root_url
    else
      render 'new'
    end
  end
  
  def edit
    @soukai = Soukai.find(params[:id])
  end
  
  def update
    @soukai = Soukai.find(params[:id])
    if @soukai.update_attributes(soukai_params)
      flash[:success] = "変更されました"
      redirect_to @soukai
    else
      render 'edit'
    end
  end
  
  def destroy
    Soukai.find(params[:id]).destroy
    flash[:success] = "Soukai deleted"
    redirect_to soukais_url
  end
  
    private

      def soukai_params
        params.require(:soukai).permit(:name, :date, :password,
                                     :password_confirmation)
      end
      
      def admin_user
        # 管理者かどうか確認
        redirect_to(root_url) unless current_user.admin?
      end
  
end
