module API
  module Entities
    class NewsPreview < Grape::Entity
      expose :id, documentation: { type: "Integer", desc: "id"}
      expose :title, documentation: { type: "String", desc: "Заоловок"}
      expose :video, documentation: { type: "String", desc: "Код"} do |video|
				video.video.split('?')[1][/v=[a-zA-Z\d]+/][2..-1] if (video.video && !(video.video.empty?))
			end
      expose :body, documentation: { type: "String", desc: "Новость"}
      expose :description, documentation: { type: "String", desc: "Описание"}
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
    class NewsList < Grape::API
      version 'v1'
      format :json
      content_type :json, "application/json;charset=UTF-8"
      rescue_from :all

      resource :news, desc: 'Новости' do
        desc "Все новости", entity: API::Entities::NewsPreview
        get do
          present News.all, with: API::Entities::NewsPreview
        end
        desc "Новости по id", entity: API::Entities::NewsPreview
        get "/:id" do
          present News.find(params[:id]), with: API::Entities::NewsPreview
        end
      end
    end
  end
end
