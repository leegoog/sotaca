$(function () {
	$('a.question').each(function () {
		$(this).click(function () {
			$(this).next().next().slideToggle();
			//alert('muh');
		})
	})
});