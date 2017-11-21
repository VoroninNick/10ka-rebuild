page_loaded_handler = ()->
  $('body').addClass('loaded');
  $('#loader-wrapper').fadeOut();


window.addEventListener('load', page_loaded_handler)
