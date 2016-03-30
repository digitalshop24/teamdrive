module API
  module Entities
    class EventPreview < Grape::Entity
      expose :id, documentation: { type: "Integer", desc: "id"}
      expose :title, documentation: { type: "String", desc: "Заоловок"}
      expose :body, documentation: { type: "String", desc: "Событие"}
      expose :video, documentation: { type: "String", desc: "Код"} do |video|
				video.video.split('?')[1][/v=[a-zA-Z\d]+/][2..-1] if (video.video && !(video.video.empty?))
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
