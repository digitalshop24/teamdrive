image = $('#images').find('.preview').find('img')
image.fadeOut('fast', function () {
	  image.attr('src', '<%= @image.image.url(:thumb) %>');
	    image.fadeIn('fast');
});
