 var columns;

 // set column number
 setColumns();

 // rerun function when window is resized 
 $(window).on('resize', function() {
   setColumns();
 });

 // the function to decide the number of columns
 function setColumns() {
   if($(window).width() <= 750) {
    $( window ).on("resize", function(){
        // Change the width of the div
            $('.poem-grid-sizer').css("width", "100%");
            $('.poem-grid-item').css("width", "100%");
    });
   } 

  if($(window).width() > 750) {
     var $container = $('.poem-grid');
     // initialize Isotope
     $container.isotope({
       // options...
       resizable: false, // disable normal resizing
       // set columnWidth to a percentage of container width
       masonry: { columnWidth: $container.width() / 3 }
     });
     $( window ).on("resize", function(){
         // Change the width of the div
             $('.poem-grid-sizer').css("width", "33%");
             $('.poem-grid-item').css("width", "33%");
     });
   }
 }