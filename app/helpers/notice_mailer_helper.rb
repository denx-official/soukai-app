module NoticeMailerHelper
  def replace_br(text)
    text = html_escape(text)
    text.gsub(/\r\n|\r|\n/, "<br>")
  end
end
