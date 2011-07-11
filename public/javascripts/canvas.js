var zi = 11;
var set_item_counter = 0;
var top = 0;
var left = 0;
var drag_w = 0;
var drag_h = 0;
var articles_in_set = [];
	
$(function () {
	$('#canvas').live("click", function (e) {
		$( ".canvas_item" ).removeClass("active_element");
	});
	$('.inventory_item').draggable({
					opacity: .5,
					revert: true,
					zindex: 9999,
					helper: 'clone',
					reverDuration: 100,
					start: function(){
				        $(this).css({opacity:0});
						drag_w =  $(this).width();
						drag_h =  $(this).height(); 
				    },
					stop: function(event, ui){
				       	// set origin again visible
				 		$(this).css({opacity:1});
				    }
	});
	$('#canvas').droppable({
					accept: ".inventory_item",
					tolerance: "intersect",
					drop: function (event, ui) {
						// add to canvas
						
						var canvas = $("#canvas").offset();
						
						alert("canvas, top: " + canvas.top +", left: " + canvas.left );
						
						addToCanvas( ui.draggable.attr("rel"), ui.draggable.attr("title"), ui.draggable.attr("id"), event.clientX-canvas.left, event.clientY-canvas.top);
					}					
	});

})	
	
addToCanvas = function (url, title, id, left, top) {
	
	// check if this article is already in the set
	if($.inArray(id, articles_in_set) >= 0) {
		alert("This article is already in your set");
		return false;
	}
	else {
		// article not yet inside, so do all the stuff 

		left = left || $('#canvas').width() / 2 ;
		top = top || $('#canvas').height() / 2;
		
		if (left > 600) left = 300;
		if (top > 460) top = 220;
		
		//alert("left: " + left + ", top: " + top);
		// load image
		$('#canvas').load(url, function() {
		  $('#canvas').append( "<div data-article='" + id + "' id='set_item_" + id + "' style='z-index: " + zi +"; width: auto; position:absolute; left: " + left + "px; top: " + top + "px;' data-rotate='0' class='canvas_item .active-element' ><img src='" + url +"' title='" + title +"' /></div");
   		  $( "#set_item_" + id).draggable({
   		  	 							containment: '#canvas',
   		  								stop: function(event, ui) { 
															updateAttributes(id); 
															
															}
   		  							});
   		  $( "#set_item_" + id+" img" ).resizable({ 
   		  									handles: 'sw, se, ne, nw',
   		  									stop: function(event, ui) { 
															
															updateAttributes(id); 
															
															}
   		 
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
		$('#drag_here').hide();
		
		// add article to array
		articles_in_set.push(id);
	}
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

changeSize = function (size) {
	var factor = (100 + (size * 10)) / 100;
	
	$('.canvas_item').each(function () {
		var diff_h, diff_w  = 0;
		var wrapper = $(this).find('.ui-wrapper');
		var image = $(this).find('img.ui-resizable');
		// save old values for difference calculation
		var width_old = image.width();
		var height_old = image.height();
		// resize the item by factor
		image.width(width_old * factor);
		image.height(height_old * factor);
		// resize wrapper as well to stay consistent with jquery ui resizable
		wrapper.width(width_old * factor);
		wrapper.height(height_old * factor);
		// get difference
		diff_w = width_old - image.width();
		diff_h = height_old - image.height();
		// change offsets by difference
		$(this).css("left", $(this).css("left")+diff_w);
		$(this).css("top", $(this).css("top")+diff_h);
		// update hidden form fields
		updateAttributes($(this).attr('data-article'));
	});
	
} 

function showCoords(evt){
  alert(
    "clientX value: " + evt.clientX + "\n"
    + "clientY value: " + evt.clientY + "\n"
  );
}
  
    