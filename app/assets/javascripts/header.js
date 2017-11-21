function init_header_menu() {
    var $mobile_menu_button = $('.mobile-menu-button');
    var $menu = $('div#header nav');
    $('.mobile-menu-button').click(function () {

        if ($menu.filter(':visible').length > 0)
            $menu.slideUp(400, function () {
                $menu.removeAttr('style');
                $menu.removeClass('expanded-menu');
                $menu.addClass('collapsed-menu');

            });

        else
            $menu.slideDown(400, function () {
                $menu.removeAttr('style');
                $menu.removeClass('collapsed-menu');

                $menu.addClass('expanded-menu');
            });
    });
    $('ul.header-nav li a').click(function () {

        var li = $(this).parent().addClass('click');
    });
}

$document.on("ready", init_header_menu)
