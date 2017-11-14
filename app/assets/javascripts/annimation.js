$(document).ready(function() {

    $('#main-cat-1').click(function() {
        if(!$('#menu-cat-1').hasClass("visited")){
            $('#menu-cat-1').slideToggle('slow', function() {
                // Animation complete.
            });
            $("#status-1").each(function (i) {
                if($(this).text() != "-"){
                    $("#status-1").text("-");
                }else{
                    $("#status-1").text("+");
                }
            });
        }
    });

});
