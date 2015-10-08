	var style = document.documentElement.style;
	support3d = (style.webkitTransition !== undefined ||
	             style.MozTransition !== undefined ||
	             style.OTransition !== undefined ||
	             style.transition !== undefined);
 
  var owl = $("#owl-featured-books");

  $('#owl-recommended-books').owlCarousel({
      items: 5,
  });

$("#owl-featured-books").owlCarousel({
    items: 1,
    // animateOut: 'fadeOut',
    animateIn: 'fadeIn',
    // loop: true,
    transitionStyle : "fade",
    autoHeight:true
}); 
