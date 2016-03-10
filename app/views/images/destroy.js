$('#images').find('#<%= @image.id %>').fadeOut('quick', function(){ 
		this.remove();
});
