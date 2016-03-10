module API
  module V1
    class Root < Grape::API
     # mount API::V1::NewsList
     # mount API::V1::Articles
      mount API::V1::Events
     # mount API::V1::Grounds
     # mount API::V1::Terrapods
    end
  end
end
