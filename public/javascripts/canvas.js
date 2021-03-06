var zi = 11;
var set_item_counter = 0;
var top = 0;
var left = 0;
var drag_w = 0;
var drag_h = 0;
var articles_in_set = [];
var preventPrompt = false;
var zaehler = 0;

// checks if the user should be prompted to leave the page or not (he will lose any progress)
closeIt = function() {
  if(true) {
        return "Are you sure that you want to leave this page?";
  }
  preventPrompt = false;
}

	
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
				        $(this).css({opacity:0.2});
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
						
						// get canvas offset to subtract from coordinates
						var canvas = $("#canvas").offset();
						
						// add to canvas
						addToCanvas( ui.draggable.attr("rel"), ui.draggable.attr("title"), ui.draggable.attr("id"), event.clientX-(canvas.left+10), event.clientY-(canvas.top-80));
					}					
	});
	
	// when submitting no need to warn user of leaving the page
	$('#article_set_submit').click(function () {
		article_set_submit = true;
	})
	
	window.onbeforeunload = function() { 
			//return "you sure??";
				return "Are you sure that you want to leave this page?";
		}
	

})	
	
addToCanvas = function (url, title, id, left, top) {
	

		// article not yet inside, so do all the stuff 

		left = left || $('#canvas').width() / 2 ;
		top = top || $('#canvas').height() / 2;
		
		if (left > 600) left = 300;
		if (top > 460) top = 220;
		
		//alert("left: " + left + ", top: " + top);
		// load image
		$('#canvas').load(url, function() {
			
			setTimeout(
			  function() 
			  {
				  $('#canvas').append( 
					"<div data-article='" + zaehler + "' data-url='" + url + "' id='set_item_" + zaehler + "' style='z-index: " + zi +"; position:absolute; left: " + left + "px; top: " + top + "px;' data-rotate='0' class='canvas_item .active-element' ><div class='delete_link'><a href='#' onclick='deleteItem(" + zaehler +");' title='remove item' >X</a></div><img src='" + url +"' title='" + title +"' /></div");



				  // make new set item draggable and resizable after short timeout
				  // setTimeout(makeDraggableAndResizable(id), 200);

				$( "#set_item_" + zaehler).draggable({
				  	 							containment: '#canvas',
				  								stop: function(event, ui) { 
																	updateAttributes(zaehler); 

																	}
				  							});


		   		  $( "#canvas .canvas_item" ).live("click", function () {
		   		  	$( ".canvas_item" ).removeClass("active_element");
		   		  	$(this).addClass("active_element");
		   		  	return false;
		   		  });


		   		  zi++;
		   		  $( ".canvas_item .ui-wrapper" ).css("overflow", "");
		   		  addSetItem(zaehler, id);
				});
				$('#drag_here').hide();


			  }, 200);
			setTimeout(
				function ()
				{
				$( "#set_item_" + zaehler + " img").resizable({ 
				  				handles: 'sw, se, ne, nw',
				  				stop: function(event, ui) { 

								updateAttributes(zaehler); 
										}

						});
			}, 200);
	zaehler++;
	
}

rotateItem = function (degree) {
	var rotation = parseInt($('.active_element').attr('data-rotate'));
	rotation += parseInt(degree);
	var id = $('.active_element').attr("data-article");
	$('.active_element').rotate(rotation);
	var rotation = $('.active_element').attr('data-rotate', rotation);
	updateAttributes(id);
}


moveItem = function (amount) {
	var z = parseInt($('.active_element').css("z-index"));
	var id = $('.active_element').attr("data-article");
	z = z + amount;
	$('.active_element').css("z-index", z);
	$('#item_' + id +'_z_index').val(z);
}

addSetItem = function(z, id, url) {
	
	// identify the div & the resizable image inside
	var item = $("#set_item_"+z);
	var image = $("#set_item_"+z+" img");
	
	// generate the additional fields for this set item
	var str = "";
	
	str += "<input type='hidden' name='article_set[set_items_attributes][" + set_item_counter + "][product_id]' value='" + id + "'/>";
	str += "<input type='hidden' id='item_" + z + "_width' name='article_set[set_items_attributes][" + set_item_counter + "][width]' value='" + image.width() + "'/>";
	str += "<input type='hidden' id='item_" + z + "_height' name='article_set[set_items_attributes][" + set_item_counter + "][height]' value='" + image.height() + "'/>";
	str += "<input type='hidden' id='item_" + z + "_z_index' name='article_set[set_items_attributes][" + set_item_counter + "][z_index]' value='" + item.css("z-index") + "'/>";
	str += "<input type='hidden' id='item_" + z + "_pos_x' name='article_set[set_items_attributes][" + set_item_counter + "][pos_x]' value='" + item.css("left") + "'/>";
	str += "<input type='hidden' id='item_" + z + "_pos_y' name='article_set[set_items_attributes][" + set_item_counter + "][pos_y]' value='" + item.css("top") + "'/>";
	str += "<input type='hidden' id='item_" + z + "_rotation' name='article_set[set_items_attributes][" + set_item_counter + "][rotation]' value='" + item.attr("data-rotate") + "'/>";
	str += "<input type='hidden' id='item_" + z + "_url' name='article_set[set_items_attributes][" + set_item_counter + "][url]' value='" + item.attr("data-url") + "'/>";
	
	var str2 = "<div id='fields_for_" + z +"'>" + str + "</div>";
	// append string to the form fields
	$('#set_items').append(str2);
	// counter increase
	set_item_counter++;
	//update
	updateAttributes(id);
}


updateAttributes = function(id) {
	var item = $("#set_item_"+id);
	var image = $("#set_item_"+id+" img");
	var item_offset = item.offset();
	var canvas_offset = $('#canvas').offset();
//	alert(item_offset);
//	alert(canvas_offset);
	$("#item_"+id +"_width").val(image.width());
	$("#item_"+id +"_height").val(image.height());
	$("#item_"+id +"_pos_x").val(item_offset.left - canvas_offset.left);
	$("#item_"+id +"_pos_y").val(item_offset.top - canvas_offset.top);
	$("#item_"+id +"_z_index").val(item.css("z-index"));
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
  
deleteItem = function (id) {
	var confirm = window.confirm("Delete this item from set?");
	
	if (confirm) {
		var item = $("#set_item_"+id);
		item.hide();
		$('#fields_for_'+id).html("");
	}
	// id needs also to be deleted from articles_in_set array
	// get index of element to delete
	var idx = articles_in_set.indexOf(id);
	articles_in_set.splice(idx, 1);
}  

discardSet = function () {
	var confirm = window.confirm("Discard this Set and delete all items?");
	if (confirm) {	
		articles_in_set = [];
		$('#canvas').html('<div id="drag_here">Drag Articles here!</div>');
		$('#set_items').html("");
	}
}
