module API
  module Entities
    class GroundPreview < Grape::Entity
      expose :title, documentation: { type: "String", desc: "Заоловок"}
      expose :body, documentation: { type: "String", desc: "Полигон"}
      expose :image, documentation: { type: "Attachment", desc: "Лого"}
      expose :images, documentation: { type: "Array", desc: "Kартинки"} do |event|
			 event.images.map{ |x| x.image.url} if event.images	
			end
    end
  end
end

module API
  module V1
    class Grounds < Grape::API
      version 'v1'
      format :json
      content_type :json, "application/json;charset=UTF-8"
      rescue_from :all

      resource :grounds, desc: 'Полигоны' do
        desc "Все полигоны", entity: API::Entities::GroundPreview
        get do
          present Ground.all, with: API::Entities::GroundPreview
        end
        desc "Полигоны по id", entity: API::Entities::GroundPreview
        get "/:id" do
          present Ground.find(params[:id]), with: API::Entities::GroundPreview
        end
      end
    end
  end
end
