window.$window = $(window)
window.$document = $(document)
window.browser= (function(){
    var N= navigator.appName, ua= navigator.userAgent, tem;
    var M= ua.match(/(opera|chrome|safari|firefox|msie)\/?\s*(\.?\d+(\.\d+)*)/i);
    if(M && (tem= ua.match(/version\/([\.\d]+)/i))!= null) M[2]= tem[1];
    //M= M? [M[1], M[2]]: [N, navigator.appVersion,'-?'];
    M={name:M[1],version:M[2]};
    return M;
})();


$document.on("ready", function () {
    $('body').addClass(browser.name.toLowerCase());
})

/*
$window.resize(function(){

    var $temp=$('<div id="home-slider"></div>').appendTo($('.banner-holder'));
    var original_height=$temp.height();
    $temp.remove();

});
*/