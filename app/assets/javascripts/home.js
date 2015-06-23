/*!
 * Start Bootstrap - Creative Bootstrap Theme (http://startbootstrap.com)
 * Code licensed under the Apache License v2.0.
 * For details, see http://www.apache.org/licenses/LICENSE-2.0.
 */

// (function($) {
    // "use strict"; // Start of use strict

    // jQuery for page scrolling feature - requires jQuery Easing plugin
    $('a.page-scroll').bind('click', function(event) {
        var $anchor = $(this);
        $('html, body').stop().animate({
            scrollTop: ($($anchor.attr('href')).offset().top - 50)
        }, 1250, 'easeInOutExpo');
        event.preventDefault();
    });

    // Highlight the top nav as scrolling occurs
    $('body').scrollspy({
        target: '.navbar-fixed-top',
        offset: 51
    })

    // Closes the Responsive Menu on Menu Item Click
    // $('.navbar-collapse ul li a').click(function() {
    //     $('.navbar-toggle:visible').click();
    // });

    // Fit Text Plugin for Main Header
    $("h1").fitText(
        1.2, {
            minFontSize: '35px',
            maxFontSize: '65px'
        }
    );

    // Offset for Main Navigation
    $('#mainNav').affix({
        offset: {
            top: 100
        }
    });

    // Initialize WOW.js Scrolling Animations
    // new WOW().init();

   $('.dropdown-toggle').dropdown();

    // Start Owl Carousel
    $("#owl-books").owlCarousel({
    	// nav : true,
    	// autoPlay : true,
    	// stopOnHover : true,
    	scrollPerPage: true,
     //    slideSpeed: 900
     // dots: true,
     // responsive:{
     //     0:{
     //         items:1
     //     },
     //     600:{
     //         items:3
     //     },
     //     1000:{
     //         items:5
     //     }
     // }
    });

    $("#owl-articles").owlCarousel({
    	nav : true,
    	autoPlay : true,
    	stopOnHover : true,
    	scrollPerPage: true,
        slideSpeed: 900
    });

    $(".owl-demo").owlCarousel({
        nav : false, // Show next and prev buttons
        slideSpeed : 300,
        paginationSpeed : 400,
        singleItem:true,
    });
    

    //Switch to Articles
    $('#switch_to_articles').click(function (event) {
      event.preventDefault(); // Prevent link from following its href
      $('#teachings_books').addClass("hide");
      $('#teachings_articles').removeClass("hide");
    });

    //Switch to Books
    $('#switch_to_books').click(function (event) {
      event.preventDefault(); // Prevent link from following its href
      $('#teachings_articles').addClass("hide");
      $('#teachings_books').removeClass("hide");
    });



// })(jQuery); // End of use strict
