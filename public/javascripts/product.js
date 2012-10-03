var scroll = 0;
var product_link = "";
	changeImage = function (url) {
		$('#main_image img:first').attr("src", url);
	}
	

	

	prepare_cart_preview = function (image, title) {
		//console.log("total before: " + total_price + ", product_price:" + product_price);
		total_amount += 1;
		total_price += product_price;
		
		//console.log("total after: " + total_price);
		
		var price_string = currency + ' ' + total_price.toString();
		var str = '<div class="popup"><div class="content">';

				str += '<p><img src="' + image +'" alt="' + title +'"></p>';
				str += '<p>You just added ' + title + ' to the cart</p>';

				str += '<p> <span id="nr_added">' + total_amount + '</span> items in cart (' + price_string +  ')</p>';
				str += '<a href="/products">continue shopping</a><br>';
				str += '<a href="/current_cart/">to the cart</a><br>';
				str += '</div></div>';
				return str;

	}
	

	
 	$(function(){
		
		$('.size_selectors select option:first-child').attr("selected", "selected");
		//console.log('product_link: ' + product_link);
	
		$('.main_image img').load(function(){
				$(this).closest('div').find('.loading').delay(100).fadeOut('slow');
		});
		$('.related_set a').tipTip();
		$('#arrow_down').click(function () {
			var h = $('#scrolldiv').height();
			if (scroll < h) {
				scroll += 100;
			}
			$('#scrolldiv').scrollTo(scroll);
		});
		$('#arrow_up').click(function () {
			if (scroll > 0) {
				scroll -= 100;
			}
			$('#scrolldiv').scrollTo(scroll);
		});
		$(window).load(function() {
			$('.loading').fadeOut('slow');
		});
	});