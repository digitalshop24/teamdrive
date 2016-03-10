module API
  module Entities
    class NewsPreview < Grape::Entity
      expose :title, documentation: { type: "String", desc: "Заоловок"}
      expose :body, documentation: { type: "String", desc: "Новость"}
      expose :description, documentation: { type: "String", desc: "Описание"}
      expose :avatar, documentation: { type: "Attachment", desc: "Лого"}
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
