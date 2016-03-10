class ImagesController < ApplicationController
	before_action :set_image, only: [:destroy, :preview]

	def destroy
		respond_to do |format|
			if @image.destroy
				flash.now[:success] = 'Изображение удалено'
			else
				flash.now[:success] = 'Ошибка'
			end
			format.html {redirect_to :back}
			format.js
	  end
	end

	def preview
		klass = params[:object_type].capitalize.constantize
		respond_to do |format|
			if @image.as_preview(klass.find(params[:object_id]))
				flash.now[:success] = 'Превью задано'
			else
				flash.now[:success] = 'Ошибка'
			end
			format.html {redirect_to :back}
			format.js
		end
 end

	private
		def set_image
			@image = Image.find(params[:id])
		end
end
