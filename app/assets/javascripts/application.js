//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require jquery.easing.min
//= require creative
//= require wow.min
//= require cbpAnimatedHeader
//= require filterrific/filterrific-jquery
//= require owl.carousel.min
//= require imagesloaded.pkgd.min
//= require isotope.pkgd.min
//= require_self
//= require books
//= require poems
//= require google_analytics
//= stub ckeditor/init
//= stub activeadmin

new WOW().init();
// Start Owl Carousel
$("#owl-books").owlCarousel({
	navigation : true,
	autoPlay : true,
	stopOnHover : true,
	scrollPerPage: true,
  slideSpeed: 900,
  items: 4,
  navigationText: [
    "<i class='fa fa-angle-left fa-4x'></i>",
    "<i class='fa fa-angle-right fa-4x'></i>",
    ],
});

$("#owl-poetry").owlCarousel({
    items: 1,
    navigation:true,
    // autoPlay : true,
    // animateOut: 'fadeOut',
    // animateIn: 'fadeIn',
    // loop: true,
    itemsDesktop: false,
    itemsDesktopSmall: false,
    itemsTablet: false,
    itemsTabletSmall: false,
    itemsMobile: false,
    navigationText: [
    "<i class='fa fa-angle-left fa-4x white'></i>",
    "<i class='fa fa-angle-right fa-4x white'></i>",
      ],
    transitionStyle : "fade",
    autoHeight:true
});

var $grid = $('.grid').isotope({
  // options...
  itemSelector: '.grid-item',
  percentPosition: true,
  masonry: {
    // use element for option
    columnWidth: '.grid-sizer'
  }
  // layoutMode: 'packery'
});
// layout Isotope after each image loads
$grid.imagesLoaded().progress( function() {
  $grid.isotope('layout');
});

  var style = document.documentElement.style;
  support3d = (style.webkitTransition !== undefined ||
               style.MozTransition !== undefined ||
               style.OTransition !== undefined ||
               style.transition !== undefined);
  var owl = $("#owl-featured-retreat_talks");
  $('#owl-recommended-retreat_talks').owlCarousel({
      items: 5,
  });

$("#owl-featured-retreat_talks").owlCarousel({
    items: 1,
    itemsDesktop: false,
    itemsDesktopSmall: false,
    itemsTablet: false,
    itemsTabletSmall: false,
    itemsMobile: false,
    autoHeight:true
});  
 $("#owl_related_retreat_talks").owlCarousel({  
  items : 4,
  itemsDesktop : [1199,3],
  itemsDesktopSmall : [979,3]
});

 var $poemGrid = $('.poem-grid').isotope({
  // options...
  itemSelector: '.poem-grid-item',
  percentPosition: true,
  masonry: {
    // use element for option
    columnWidth: '.poem-grid-sizer',
    gutter: 10
  }
  // layoutMode: 'packery'
});
// layout Isotope after each image loads
$poemGrid.imagesLoaded().progress( function() {
  $poemGrid.isotope('layout');
});
$(document).ready(function(){
    $('#new_feedback')
    .on('ajax:send', function(e,d,s,x) {
      $('#reportalert').html('<br><i class="fa fa-2x fa-circle-o-notch fa-spin"></i>');
    })
    .on('ajax:success', function(e,d,s,x) {
      $('#reportalert').html('<br><span>Thank you!</span><hr><a href="/">Back to Main Page</a>');
      document.getElementById("new_feedback").reset();
    })
    .on('ajax:error',function(e, data, status, error){
      console.log(data);
      errorText = JSON.parse(data.responseText);
      for (var key in errorText) {
        $('#reportalert').html('<br><span style="color:red; font-weight:bold;">'+ key + ' ' + errorText[key] + '</span><br>');
      }
    });
    $('select.changeStatus').change(function(){
      $('.retreat_talk_audio').addClass('hide');
      $('#audio'+ ($('select.changeStatus').val())).removeClass('hide');
    });
  });
$('#buddhadasa-nav').affix({
  offset: {
    top: 100,
    bottom: 350
    // bottom: function () {
    //   return (this.bottom = $('.footer').outerHeight(true))
    // }
  }
});
$("#owl-demo").owlCarousel({
    nav : false, // Show next and prev buttons
    slideSpeed : 300,
    paginationSpeed : 400,
    singleItem:true,
    autoHeight:true
});
$('#suanmokkh-nav').affix({
  offset: {
    top: 130,
    bottom: 350
    // bottom: function () {
    //   return (this.bottom = $('.footer').outerHeight(true))
    // }
  }
});