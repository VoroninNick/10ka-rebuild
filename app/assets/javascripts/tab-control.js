(function( $ ){

  $.fn.tabcontrol = function( options ) {  

    // Create some defaults, extending them with any options that were provided
    var settings = $.extend( {
    }, options);



    return this.each(function() {        

      // Tooltip plugin code here
      var that=this;

      that.tabcontrol=$(that);
      that.tabs=[];
    });

  };
})( jQuery );