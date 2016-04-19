module API
  module Entities
    class TerrapodPreview < Grape::Entity
      regex = /^(?:http(?:s)?:\/\/)?(?:www\.)?(?:m\.)?(?:youtu\.be\/|youtube\.com\/(?:(?:watch)?\?(?:.*&)?v(?:i)?=|(?:embed|v|vi|user)\/))([^\?&\"'>]+)/
      expose :id, documentation: { type: "Integer", desc: "id"}
      expose :title, documentation: { type: "String", desc: "Заоловок"}
      expose :preview, documentation: { type: "Attachment", desc: "Одна картинка"} do |terra|
				terra.preview.url if terra.image
			end
      expose :video, documentation: { type: "String", desc: "Код"} do |video|
				video.video.scan(regex).flatten.first if (video.video && !(video.video.empty?))
			end
      expose :body, documentation: { type: "String", desc: "Событие"}
      expose :price, documentation: { type: "String", desc: "Цена"}
      expose :image, documentation: { type: "Array", desc: "Kартинки"} do |event|
			 event.image.image.url if event.image	
			end
			expose :count do |c|
				0
			end
			expose :price_user do |c|
				0
			end
			expose :images, documentation: { type: "Array", desc: "Kартинки"} do |event|
			 event.images.map{ |x| x.image.url} if event.images	
			end
    end
  end
end

module API
  module V1
    class Terrapods < Grape::API
      version 'v1'
      format :json
      content_type :json, "application/json;charset=UTF-8"
      rescue_from :all

      resource :terrapods, desc: 'Терраподы' do
        desc "Все терраподы", entity: API::Entities::TerrapodPreview
        get do
          present Terrapod.all, with: API::Entities::TerrapodPreview
        end
        desc "Терапод по id", entity: API::Entities::TerrapodPreview
        get "/:id" do
          present Terrapod.find(params[:id]), with: API::Entities::TerrapodPreview
        end
      end
    end
  end
end
