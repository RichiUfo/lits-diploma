//= require jquery
//= require jquery_ujs 
//= require_tree .
//= require flat-ui.min
//= require masonry/jquery.masonry
//= require masonry/modernizr-transitions

$(function(){
  $('#masonry-container').masonry({
    itemSelector: '.box',
    isAnimated: !Modernizr.csstransitions,
    isFitWidth: true
  });
});
