class Event::Category
  include Ehon
  
  OTHER = enum 0, name: "その他"
  MAIN_EVENT = enum 1, name: "メインイベント"
  LECTURE = enum 2, name: "講座"
  MINI_HACKATHON = enum 3, name: "ミニハッカソン"
  
  def self.find(name)
    Event::Category.all.find {|c| c.name == name } || 0
  end
  
end