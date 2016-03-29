ActiveAdmin.register Ground do
permit_params :video, :body, :title, images: []
form do |f|
	  f.inputs do
		  f.input :title
		  f.input :video
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

show do |article|
	attributes_table do
		row :images do
			render(partial: 'images/images_with_preview', locals: { object: article, page: 'show' } )
		end		
		row :title
		row :body do |article|
			article.body.html_safe
		end
	end
end
index do
	selectable_column
		column :title
		column :body do |event|
			event.body.html_safe
		end
		actions
end


end
