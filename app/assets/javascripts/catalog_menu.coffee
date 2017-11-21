$document.on "click", ".expander", (e)->
  e.preventDefault()
  $(this).parent().next().toggleClass("show")
