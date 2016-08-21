class StaticPagesController < ApplicationController
  include Common
  before_action :detect_devise_variant
  layout :select_layout
  
  def home
    @a=request.from_smartphone?
  end

  def help
  end
  
  private
    def detect_devise_variant
      if request.from_smartphone?
        request.variant = :mobile
      end
    end
end
