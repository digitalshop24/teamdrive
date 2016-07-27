Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
	delete 'admin/images/:id', to: 'images#destroy', as: :destroy_image
  get 'admin/images/:id/:object_type/:object_id', to: 'images#preview', as: :preview_image
  devise_for :admin_users, ActiveAdmin::Devise.config
  mount API::Root => '/'
  mount GrapeSwaggerRails::Engine => '/apidoc'
	ActiveAdmin.routes(self)
  root :to => "home#index"
end
