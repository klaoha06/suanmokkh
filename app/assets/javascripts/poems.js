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

// debugger;