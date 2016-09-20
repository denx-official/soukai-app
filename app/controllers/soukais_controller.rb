class SoukaisController < ApplicationController
  include Common
  layout        :select_layout
  before_action :admin_user, only: [:new, :create, :edit, :update, :destroy]
  
  def index
    @soukais = Soukai.narrow_year(Date.today.year)
  end
  
  def show
    @soukai = Soukai.find(params[:id])
    @user = []
    Attendance.where(soukai_id: params[:id]).order("user_id").each do |n|
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
      redirect_to @soukai
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
    flash[:success] = "総会を削除しました"
    redirect_to soukais_url
  end
  
    private

      def soukai_params
        params.require(:soukai).permit(:name, :date, :password,
                                     :password_confirmation)
      end
  
end
