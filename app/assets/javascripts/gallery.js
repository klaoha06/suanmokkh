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