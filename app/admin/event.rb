ActiveAdmin.register Event do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :body, :title, images: []
#
# or
form do |f|
	  f.inputs do
		  f.input :title
		  f.input :body, :as => :ckeditor
			f.input :images, as: :file, input_html: { multiple: true }
			li id: 'images' do
			div class: 'inline-hints' do
				render(partial: 'images/images_with_preview', locals: { object: f.object, page: 'edit' })
			end
	  end
		end
		f.actions
end

show do |event|
	attributes_table do
		row :images do
			render(partial: 'images/images_with_preview', locals: { object: event, page: 'show' } )
		end		
		row :title
		row :body do |event|
			event.body.html_safe
		end
	end
end
index do
		column :title
		column :body do |event|
			event.body.html_safe
		end
		actions
end
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end


end
