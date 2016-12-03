//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require_directory .
//= require masonry/jquery.masonry
//= require masonry/modernizr-transitions
//= require sidebar

$(document).ready(function() {
  var $sideBar = $('.ui.sidebar').sidebar({
    transition: 'overlay', 
  }),
  $masonryContainer = $('#masonry-container'),
  $sidebarToggle = $('.sidebar-toggle');

  executeAfterLoading($masonryContainer.find('img'), function(){
    $masonryContainer.masonry({
      itemSelector: '.box',
      isAnimated: !Modernizr.csstransitions,
      isFitWidth: true
    });
  });

  $sidebarToggle.on('click', function(e) {
    e.preventDefault();
    $sideBar.sidebar('toggle');
  });
});


function executeAfterLoading($jQobject, callback) {
  var total = $jQobject.length,
    loaded = 0;

  $jQobject.on('load', function() {
    loaded++;

    if (total == loaded) {
      callback();
    }
  });
}
