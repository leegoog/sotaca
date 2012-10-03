// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults


$(function (){
	if( !$.trim( $('#left').html() ).length == 0 ) {
		var h = 0;
		h = $('#content').height();
		$('#left').height(h);
	}
});

function remove_fields(link) {
	$(link).prev("input[type=hidden]").val("1");
	$(link).closest(".image_field").hide('fast');
}

function scrollDiv(direction) {
  if (direction.toString() == "up") {
  	scroll = scroll  - 100;
  }
  else {
  	scroll = scroll  + 100;
  }

  $('#scrolldiv').scrollTo(500);
  
  if (scroll < 0) {
  	scroll = 0;
  }
  	
  	
  if (scroll > $('#scrolldiv').height()) {
  	scroll = $('#scrolldiv').height();
  }
			
}