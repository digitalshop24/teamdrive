module API
  module Entities
    class ArticlePreview < Grape::Entity
      expose :id, documentation: { type: "Integer", desc: "id"}
      expose :title, documentation: { type: "String", desc: "Заоловок"}
      expose :body, documentation: { type: "String", desc: "Статья"}
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
    class Articles < Grape::API
      version 'v1'
      format :json
      content_type :json, "application/json;charset=UTF-8"
      rescue_from :all

      resource :articles, desc: 'Статьи' do
        desc "Все статьи", entity: API::Entities::ArticlePreview
        get do
          present Article.all, with: API::Entities::ArticlePreview
        end
        desc "Статьи по id", entity: API::Entities::ArticlePreview
        get "/:id" do
          present Article.find(params[:id]), with: API::Entities::ArticlePreview
        end
      end
    end
  end
end
