// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require turbolinks
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require jquery.easing.min
//= require owl.carousel.min
//= require wow.min
//= require creative
//= require filterrific/filterrific-jquery
//= require imagesloaded.pkgd.min
//= require isotope.pkgd.min
//= require_self
//= require books
//= require poems
//= require google_analytics
//= stub active_admin/application
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
