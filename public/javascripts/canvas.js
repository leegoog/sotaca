var zi = 11;
var set_item_counter = 0;
	
$(function () {
	$('#canvas').live("click", function (e) {
		$( ".canvas_item" ).removeClass("active_element");
	})
})	
	
addToCanvas = function (url, title, id) {
	
	// load image
	$('#canvas').load(url, function() {
	  $('#canvas').append( "<div data-article='" + id + "' id='set_item_" + id + "' style='z-index: " + zi +"; width: auto; position:absolute;' data-rotate='0' class='canvas_item .active-element' ><img src='" + url +"' title='" + title +"' /></div");
   	  $( ".canvas_item" ).draggable({
   	  	 							containment: '#canvas',
   	  								stop: function(event, ui) { updateAttributes(id); }
   	  							});
   	  $( ".canvas_item img" ).resizable({ 
   	  									handles: 'sw, se, ne, nw',
   	  									stop: function(event, ui) { updateAttributes(id); }
   	 
   	  								});
   	  $( "#canvas .canvas_item" ).live("click", function () {
   	  	$( ".canvas_item" ).removeClass("active_element");
   	  	$(this).addClass("active_element");
   	  	return false;
   	  });
   	  zi++;
   	  $( ".canvas_item .ui-wrapper" ).css("overflow", "");
   	  addSetItem(id);
	});
}

rotateItem = function (degree) {
	var rotation = parseInt($('.active_element').attr('data-rotate'));
	rotation += parseInt(degree);
	var id = parseInt($('.active_element').attr("data-article"));
	$('.active_element').rotate(rotation);
	var rotation = $('.active_element').attr('data-rotate', rotation);
	updateAttributes(id);
}


moveItem = function (amount) {
	var z = parseInt($('.active_element').css("z-index"));
	var id = parseInt($('.active_element').attr("data-article"));
	z = z + amount;
	$('.active_element').css("z-index", z);
	updateAttributes(id);
}

addSetItem = function(id) {
	
	// identify the div & the resizable image inside
	var item = $("#set_item_"+id);
	var image = $("#set_item_"+id+" img");
	
	// generate the additional fields for this set item
	var str = "";
	
	str += "<input type='hidden' name='article_set[set_items_attributes][" + set_item_counter + "][product_id]' value='" + id + "'/>";
	str += "<input type='hidden' id='item_" + id + "_width' name='article_set[set_items_attributes][" + set_item_counter + "][width]' value='" + image.css("width") + "'/>";
	str += "<input type='hidden' id='item_" + id + "_height' name='article_set[set_items_attributes][" + set_item_counter + "][height]' value='" + image.css("height") + "'/>";
	str += "<input type='hidden' id='item_" + id + "_z_index' name='article_set[set_items_attributes][" + set_item_counter + "][z_index]' value='" + item.css("z-index") + "'/>";
	str += "<input type='hidden' id='item_" + id + "_pos_x' name='article_set[set_items_attributes][" + set_item_counter + "][pos_x]' value='" + item.css("left") + "'/>";
	str += "<input type='hidden' id='item_" + id + "_pos_y' name='article_set[set_items_attributes][" + set_item_counter + "][pos_y]' value='" + item.css("top") + "'/>";
	str += "<input type='hidden' id='item_" + id + "_rotation' name='article_set[set_items_attributes][" + set_item_counter + "][rotation]' value='" + item.attr("data-rotate") + "'/>";
	
	var str2 = "<div id='fields_for_" + id +"'>" + str + "</div>";
	// append string to the form fields
	$('#set_items').append(str2);
	// counter increase
	set_item_counter++;
	
}


updateAttributes = function(id) {
	var item = $("#set_item_"+id);
	var image = $("#set_item_"+id+" img");
	
	$("#item_"+id +"_width").val(image.css("width"));
	$("#item_"+id +"_height").val(image.css("height"));
	$("#item_"+id +"_pos_x").val(item.css("left"));
	$("#item_"+id +"_pos_y").val(item.css("top"));
	$("#item_"+id +"_pos_z_index").val(item.css("z-index"));
	$("#item_"+id +"_rotation").val(item.attr("data-rotate"));
}