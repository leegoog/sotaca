var zi = 11;
	
addToCanvas = function (url, title) {
	$('#canvas').append( "<div style='z-index: " + zi +"; width: auto; position:absolute' class='canvas_item' ><img src='" + url +"' title='" + title +"' /></div");
	$( ".canvas_item" ).draggable({ containment: '#canvas' });
	$( ".canvas_item img" ).resizable();
}