//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require_directory .
//= require masonry/jquery.masonry
//= require masonry/modernizr-transitions
//= require sidebar

$(document).ready(function() {
  register.onTopButton();
  register.sideBarToggle();
  register.masonry();
});

var $sideBar = $('.ui.sidebar').sidebar({ transition: 'overlay' }),
    $masonryContainer = $('#masonry-container'),
    $sidebarToggle = $('.sidebar-toggle'),
    $onTopButton = $('#on-top-button');

var register = {
  masonry: function () {
    helper.executeAfterLoading($masonryContainer.find('img'), function(){
      $masonryContainer.masonry({
        itemSelector: '.box',
        isAnimated: !Modernizr.csstransitions,
        isFitWidth: true
      });
    });
  },

  onTopButton: function () {
    var button_visible = 300, 
      delay = 1000;

    $(window).scroll(function () {
      if ($(this).scrollTop() > button_visible) {
        $onTopButton.fadeIn();
      } else {
        $onTopButton.fadeOut();
      }
    });

    $onTopButton.click(function () {
      $('body, html').animate({
        scrollTop: 0
      }, delay);
    });
  },
  
  sideBarToggle: function () {
    $sidebarToggle.on('click', function(e) {
      e.preventDefault();
      $sideBar.sidebar('toggle');
    });
  }
};

var helper = {
  executeAfterLoading: function ($jQobject, callback) {
    var total = $jQobject.length,
      loaded = 0;

    $jQobject.on('load', function() {
      loaded++;

      if (total == loaded) {
        callback();
      }
    });
  }
};

