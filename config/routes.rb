Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
	delete 'admin/images/:id', to: 'images#destroy', as: :destroy_image
  get 'admin/images/:id/:object_type/:object_id', to: 'images#preview', as: :preview_image
  get 'events/:id/', to: 'home#show_event', as: :events_id
  get 'map', to: 'home#show_map', as: :show_map
  get 'terrapod/:id/', to: 'home#show_terrapod', as: :terrapod_id
  devise_for :admin_users, ActiveAdmin::Devise.config
  mount API::Root => '/'
  mount GrapeSwaggerRails::Engine => '/apidoc'
	ActiveAdmin.routes(self)
  root :to => "home#index"
end
