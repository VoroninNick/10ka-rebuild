hide_breadcrumbs_dropdown = ()->
  $active_item = $(".breadcrumbs").find(".has-opened-dropdown")
  $dropdown = $active_item.find(".dropdown")
  $dropdown.removeClass("opened")
  $active_item.removeClass("has-opened-dropdown")
$(".breadcrumbs > ul > li").filter(":not(:last-child)").append(svg_images.arrow_right)

$document.on "click", ".breadcrumbs .has-dropdown > a, .has-dropdown > span", (e)->
  e.preventDefault()
  $li = $(this).parent()
  $dropdown = $li.children().filter(".dropdown")
  opened = $li.hasClass("has-opened-dropdown")
  hide_breadcrumbs_dropdown()
  if !opened
    $dropdown.addClass("opened")
    $li.addClass("has-opened-dropdown")




$.clickOut(".breadcrumbs .dropdown.opened",
  hide_breadcrumbs_dropdown
  {except: ".breadcrumbs > ul > li"}
)