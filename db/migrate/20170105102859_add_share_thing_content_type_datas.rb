class AddShareThingContentTypeDatas < ActiveRecord::Migration
  def change
    ShareThing::ContentType.create(name: "URL")
    ShareThing::ContentType.create(name: "他")
  end
end
