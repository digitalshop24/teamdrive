module API
  module Entities
    class EventPreview < Grape::Entity
      regex = /^(?:http(?:s)?:\/\/)?(?:www\.)?(?:m\.)?(?:youtu\.be\/|youtube\.com\/(?:(?:watch)?\?(?:.*&)?v(?:i)?=|(?:embed|v|vi|user)\/))([^\?&\"'>]+)/
      expose :id, documentation: { type: "Integer", desc: "id"}
      expose :title, documentation: { type: "String", desc: "Заоловок"}
      expose :body, documentation: { type: "String", desc: "Событие"}
      expose :video, documentation: { type: "String", desc: "Код"} do |video|
				video.video.scan(regex).flatten.first if (video.video && !(video.video.empty?))
			end
      expose :image, documentation: { type: "Array", desc: "Kартинки"} do |event|
			 event.image.image.url if event.image	
			end
      expose :images, documentation: { type: "Array", desc: "Kартинки"} do |event|
			 event.images.map{ |x| x.image.url} if event.images	
			end
    end
  end
end

module API
  module V1
    class Events < Grape::API
      version 'v1'
      format :json
      content_type :json, "application/json;charset=UTF-8"
      rescue_from :all

      resource :events, desc: 'События' do
        desc "Все события", entity: API::Entities::EventPreview
        get do
          present Event.all, with: API::Entities::EventPreview
        end
        desc "Событие по id", entity: API::Entities::EventPreview
        get "/:id" do
          present Event.find(params[:id]), with: API::Entities::EventPreview
        end
      end
    end
  end
end
