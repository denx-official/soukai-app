class User::RemindEventCategory < ActiveRecord::Base
  validates :user_id, :uniqueness => {scope: :event_category_id}
end
