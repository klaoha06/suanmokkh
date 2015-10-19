$( document ).ready(function() {
  var style = document.documentElement.style;
  support3d = (style.webkitTransition !== undefined ||
               style.MozTransition !== undefined ||
               style.OTransition !== undefined ||
               style.transition !== undefined);
 
  var owl = $("#owl-featured-books");

$('#owl-recommended-books').owlCarousel({
    items: 5,
});

owl.owlCarousel({
    items: 1,
    stopOnHover: true,
    // autoPlay : true,
    // animateOut: 'fadeOut',
    pagination: false,
    animateIn: 'fadeIn',
    // loop: true,
    navigation:true,
    navigationText: [
    "<i class='books_arrow fa fa-angle-left white fa-4x hide'></i>",
    "<i class='books_arrow fa fa-angle-right white fa-4x hide'></i>",
      ],
    transitionStyle : "fade",
    autoHeight:true
}); 


$('.featured')
  .hover(
    function() {
      $( ".books_arrow" ).fadeIn().removeClass('hide');
    }, function() {
      $( ".books_arrow" ).fadeOut();
    }
  );
});

