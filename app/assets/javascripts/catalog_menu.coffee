$document.on "click", ".catalog-show-more", (e)->
  $(this).next().toggleClass("show")