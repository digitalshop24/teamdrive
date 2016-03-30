module API
  module Entities
    class GroundPreview < Grape::Entity
      expose :id, documentation: { type: "Integer", desc: "id"}
      expose :title, documentation: { type: "String", desc: "Заоловок"}
      expose :body, documentation: { type: "String", desc: "Полигон"}
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
