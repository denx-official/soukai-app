class AttendancesController < ApplicationController
  include Common
  
  def new
    @month = {:"1月" => "jan", :"2月" => "feb", :"3月" => "mar"}
  end
  
  def create
    @month = {:"1月" => "jan", :"2月" => "feb", :"3月" => "mar"}
    month = Attendance.find(current_user.id)
    month[params[:month]] = true
    month.save
    # binding.pry
    render 'new'
  end
end
