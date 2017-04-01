class SendMailsController < ApplicationController
  include Common
  
  def index
  end
  
  def create
    if params[:to].present?
      users = User.where(entrance_year: params[:to].split.map(&:to_i))
    else
      users = User.all
    end
    if users.present?
      NoticeMailer.send_notice(users, params[:subject], params[:body])
      flash[:info] = "送信しました"
      redirect_to root_url
    else
      flash[:danger] = "送信先のユーザーが見つかりませんでした。"
      redirect_to root_url
    end
  end
  
end