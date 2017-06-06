class RemindMailsController < ApplicationController
  include Common
  before_action :logged_in_user
  before_action :set_user
  before_action :set_remind_event_categories
  before_action :set_event_categories

  def edit
  end
  
  def update
    Event::Category.all.each do |category|
      remind = @remind_event_category_map[category.id]
      is_remind = params[category.name].present?
      remind_before_day = params["#{category.name}_remind_before_day"].to_i if params["#{category.name}_remind_before_day"]
      if remind.present?
        remind.is_remind = is_remind
        remind.remind_before_day = remind_before_day if remind_before_day.present?
      else
        remind = User::RemindEventCategory.new(user_id: @user.id, event_category_id: category.id, is_remind: is_remind, remind_before_day: remind_before_day)
      end
      unless remind.save
        flash[:error] = "リマインド設定の登録に失敗しました"
        render "edit"
      end
    end
    
    flash[:success] = "リマインド設定が登録されました"
    redirect_to edit_remind_mail_path(@user)
  end
  
  private
  
    def set_user
      @user = User.find(params[:id].to_i)
    end
  
    def set_remind_event_categories
      @remind_event_category_map = User::RemindEventCategory.where(user_id: params[:id].to_i).each_with_object({}) {|ur, array| array[ur.event_category_id] = ur }
    end
    
    def set_event_categories
      @event_categories = Event::Category.all
      @event_categories << @event_categories.shift(1)
      @event_categories.flatten!
    end
  
end