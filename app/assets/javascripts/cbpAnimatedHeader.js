/**
 * cbpAnimatedHeader.js v1.0.0
 * http://www.codrops.com
 *
 * Licensed under the MIT license.
 * http://www.opensource.org/licenses/mit-license.php
 * 
 * Copyright 2013, Codrops
 * http://www.codrops.com
 */
var cbpAnimatedHeader = (function() {

	var docElem = document.documentElement,
		header = document.querySelector( '.navbar-default' ),
		didScroll = false,
		changeHeaderOn = 300;

	function init() {
		window.addEventListener( 'scroll', function( event ) {
			if( !didScroll ) {
				didScroll = true;
				setTimeout( scrollPage, 250 );
			}
		}, false );
	}

	function scrollPage() {
		var sy = scrollY();
		if ( sy >= changeHeaderOn ) {
			classie.add( header, 'navbar-shrink' );
		}
		else {
			classie.remove( header, 'navbar-shrink' );
		}
		didScroll = false;
	}

	function scrollY() {
		return window.pageYOffset || docElem.scrollTop;
	}

	init();

})();

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
 new WOW().init();

$('.dropdown-toggle').dropdown();