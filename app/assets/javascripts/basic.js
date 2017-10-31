$(document).ready(function(){
    $("#link_to_ie8").fancybox({
        maxWidth	: '90%',
        //maxHeight	: 600,
        fitToView	: false,
        width		: '100%',
        height		: '100%',
        autoSize	: false,
        closeClick  : false, // prevents closing when clicking INSIDE fancybox
        helpers     : {
            overlay : {closeClick: false} // prevents closing when clicking OUTSIDE fancybox
        },
        closeBtn: false,
        openEffect	: 'none',
        closeEffect	: 'none'
    });
    if( $("html").hasClass("ie8") ) {
        $('#link_to_ie8').trigger('click');
    }
});