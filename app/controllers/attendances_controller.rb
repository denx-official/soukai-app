class AttendancesController < ApplicationController
  include Common
  before_action :logged_in_user, only: [:new, :create]
  before_action :set_soukai, only: [:new, :create]
  
  def new
    @attendance = Attendance.new
  end
  
  def create
    if params[:attendance][:soukai_id].blank?
      flash.now[:danger] = "総会が選択されていません"
      render 'new'
    else
      soukai = @soukai.find(params[:attendance][:soukai_id])
      @attendance = Attendance.new(soukai_id: params[:attendance][:soukai_id], user_id: current_user.id)
      if @attendance && soukai.authenticate(params[:attendance][:password])
        if @attendance.save
          flash[:info] = "出席しました"
          redirect_to root_url
        else
          flash.now[:warning] = "#{soukai.name}はすでに出席してます"
          render 'new'
        end
      else
        flash.now[:danger] = 'Passwordが間違ってます'
        render 'new'
      end
    end
  end
  
  private
    def set_soukai
      @soukai = Soukai.narrow_year(Date.today.year)
    end
  
end
