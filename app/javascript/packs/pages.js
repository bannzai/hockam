$(document).ready(function() {
	$('[id^=carousel-slider]').carousel({
		interval: 1800,
    pause: false,
	});
	$('.carousel .carousel-item').each(function(){
		let next = $(this).next();
		if (!next.length) {
			next = $(this).siblings(':first');
		}
		next.children(':first-child').clone().appendTo($(this));

		const minPerSlide = 3;
		for (let i = 0; i < minPerSlide; i++) {
			next = next.next();
			if (!next.length) {
				next = $(this).siblings(':first');
			}

			next.children(':first-child').clone().appendTo($(this));
		}
	});
});

