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
    itemsDesktop: false,
    itemsDesktopSmall: false,
    itemsTablet: false,
    itemsTabletSmall: false,
    itemsMobile: false,
    pagination: false,
    animateIn: 'fadeIn',
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

  $('select.changeStatus').change(function(){
      $('.embeded_audio').addClass('hide');
      $('#audio'+ ($('select.changeStatus').val())).removeClass('hide').addClass('animated fadeIn');
  });
  $('select.bookStatus').change(function(){
        $('.mobile-btn').addClass('hide');
        $('#book-mobile'+ ($('select.bookStatus').val())).removeClass('hide').addClass('animated fadeIn');
        $('.embeded_book').addClass('hide');
        $('#book'+ ($('select.bookStatus').val())).removeClass('hide').addClass('animated fadeIn');      
  });
});

