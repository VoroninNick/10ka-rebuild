$document.on "click", "#catalog-page-wrapper .catalog-block .catalog-category > .node-title", (e)->
  e.preventDefault()
  $(this).closest(".catalog-category").find(".catalog-menu").toggleClass("show")
