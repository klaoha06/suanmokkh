/*!
 * Start Bootstrap - Creative Bootstrap Theme (http://startbootstrap.com)
 * Code licensed under the Apache License v2.0.
 * For details, see http://www.apache.org/licenses/LICENSE-2.0.
 */

// (function($) {
    // "use strict"; // Start of use strict

   //  // jQuery for page scrolling feature - requires jQuery Easing plugin
   //  $('a.page-scroll').bind('click', function(event) {
   //      var $anchor = $(this);
   //      $('html, body').stop().animate({
   //          scrollTop: ($($anchor.attr('href')).offset().top - 50)
   //      }, 1250, 'easeInOutExpo');
   //      event.preventDefault();
   //  });

   //  // Highlight the top nav as scrolling occurs
   //  $('body').scrollspy({
   //      target: '.navbar-fixed-top',
   //      offset: 51
   //  })

   //  // Closes the Responsive Menu on Menu Item Click
   //  // $('.navbar-collapse ul li a').click(function() {
   //  //     $('.navbar-toggle:visible').click();
   //  // });

   //  // Fit Text Plugin for Main Header
   //  $("h1").fitText(
   //      1.2, {
   //          minFontSize: '35px',
   //          maxFontSize: '65px'
   //      }
   //  );

   //  // Offset for Main Navigation
   //  $('#mainNav').affix({
   //      offset: {
   //          top: 100
   //      }
   //  });

   // $('.dropdown-toggle').dropdown();
   
    // Initialize WOW.js Scrolling Animations
    // new WOW().init();


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

    $("#owl-articles").owlCarousel({
    	nav : true,
    	autoPlay : true,
    	stopOnHover : true,
    	scrollPerPage: true,
        slideSpeed: 900
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



// })(jQuery); // End of use strict
