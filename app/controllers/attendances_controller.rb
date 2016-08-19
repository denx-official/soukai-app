class AttendancesController < ApplicationController
  include Common
  before_action :logged_in_user, only: [:new, :create]
  
  def new
    @month = Soukai.all
    @attendance = Attendance.new
  end
  
  def create
    @month = Soukai.all
    @soukai = Soukai.find(params[:attendance][:soukai_id])
    @attendance = Attendance.new(soukai_id: params[:attendance][:soukai_id], user_id: current_user.id)
    if @attendance && @soukai.authenticate(params[:attendance][:password])
      if @attendance.save
        flash[:info] = "出席しました"
        redirect_to root_url
      else
        render 'new'
      end
    else
      flash.now[:danger] = 'Passwordが間違ってます'
      render 'new'
    end
  end
  
    private
      # ログイン済みユーザーかどうか確認
      def logged_in_user
        unless logged_in?
          store_location
          flash[:danger] = "Please log in."
          redirect_to login_url
        end
      end
end
