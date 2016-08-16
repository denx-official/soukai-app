module UsersHelper

  # 引数で与えられたユーザーのGravatar画像を返す
  def gravatar_for(user, options = { size: 80 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end
  
  def set_month(user)
    @jan = Attendance.where(user_id: user, soukai_id: 1).present?
    @feb = Attendance.where(user_id: user, soukai_id: 2).present?
    @mar = Attendance.where(user_id: user, soukai_id: 3).present?
    @apr = Attendance.where(user_id: user, soukai_id: 4).present?
    @may = Attendance.where(user_id: user, soukai_id: 5).present?
    @jun = Attendance.where(user_id: user, soukai_id: 6).present?
    @jul = Attendance.where(user_id: user, soukai_id: 7).present?
    @aug = Attendance.where(user_id: user, soukai_id: 8).present?
    @sep = Attendance.where(user_id: user, soukai_id: 9).present?
    @oct = Attendance.where(user_id: user, soukai_id: 10).present?
    @nov = Attendance.where(user_id: user, soukai_id: 11).present?
    @dec = Attendance.where(user_id: user, soukai_id: 12).present?
  end
end