function init_contact_form() {
    var validationSettings = {
        errorMessagePosition: 'top'
    };

    $('#contact_us')
        .submit(function () {
            if ($(this).validate(false, validationSettings)) {
                var $form = $('#contact_us');
            }
        })
        .validateOnBlur(false, validationSettings)
        .showHelpOnFocus();
}

function init_google_map(){
    var map_element = document.getElementById("map")
    if (!map_element){
        return;
    }

    $.ajax('xml/gmap.xml',
        {success:function(xml){
            fullxml=xml;
            if($('status',xml).text()=='OK')
            {


                var lat= 49.8163609;
                var lng= 23.9259267;
                var myLatlng = new google.maps.LatLng(lat, lng);
                var myOptions = {
                    zoom: 15,
                    center: myLatlng,
                    mapTypeId: google.maps.MapTypeId.ROADMAP,
                    scrollwheel: false
                };
                var map = new google.maps.Map(document.getElementById("map"), myOptions);

                var marker = new google.maps.Marker({
                    position: myLatlng,
                    map: map,
                    title:"Гуртівня будівельних товарів \"Десятка\""
                });
            }
        }

        });
    $(window).resize(function(){
        var h=window.innerHeight;
        $('#map').css('max-height',h);
        console.log('h:'+h);
    })
}

$document.on("ready", function () {
    init_contact_form()
    init_google_map()

})


