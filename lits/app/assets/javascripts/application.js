//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require masonry/jquery.masonry
//= require masonry/modernizr-transitions
//= require sidebar
//= require chosen-jquery
//= require_directory .

$(document).ready(function() {
  app.onTopButton();
  app.sideBarToggle();
  app.masonry();
});

var $sideBar = $('.ui.sidebar').sidebar({ transition: 'overlay', mobileTransition: 'overlay' }),
    $masonryContainer = $('#masonry-container'),
    $sidebarToggle = $('.sidebar-toggle'),
    $onTopButton = $('#on-top-button');

var app = {
  onTopButtonAppears: 300,
  onTopDelay: 700,

  masonry: function () {
    $masonryContainer.imagesLoaded().always(function(){
      $masonryContainer.masonry({
        itemSelector: '.box',
        isAnimated: !Modernizr.csstransitions,
        isFitWidth: true
      });
    });
  },

  onTopButton: function () {
    $(window).scroll(function () {
      if ($(this).scrollTop() > this.onTopButtonAppears) {
        $onTopButton.fadeIn();
      } else {
        $onTopButton.fadeOut();
      }
    });

    $onTopButton.click(function () {
      $('body, html').animate({
        scrollTop: 0
      }, this.onTopDelay);
    });
  },
  
  sideBarToggle: function () {
    $sidebarToggle.on('click', function(e) {
      e.preventDefault();
      $sideBar.sidebar('toggle');
    });
  }
};
