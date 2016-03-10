module API
  module Entities
    class EventPreview < Grape::Entity
      expose :title, documentation: { type: "String", desc: "Заоловок"}
      expose :body, documentation: { type: "String", desc: "Событие"}
      expose :image, documentation: { type: "Attachment", desc: "Лого"}
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
