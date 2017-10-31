
 HomeSlider=function (slider)
{

    var that=this;

    that.activeIndex=0;
    that.slides_count=0;
    that.options={
        titleIndent:0,
        titleWidth:55,
        slideWidth:1120-3*88,
        position:1,
        allowAuto:false,
        timeout:5000,
        speed:1000,
        displayHeaders:true
};
    that.images=[];
    that.slides=[];
    that.headers=[];
    that.slider=$(slider);
    that.timer_id=false;
    that.sliderHeight=that.slider.get(0).offsetHeight;
    that.sliderWidth=that.slider.get(0).offsetWidth;

    // Convert a css px value to int.
    that.ConvertCssPxToInt=function(cssPxValueText) {

        // Set valid characters for numeric number.
        var validChars = "0123456789.";

        // If conversion fails return 0.
        var convertedValue = 0;

        // Loop all characters of
        for (i = 0; i < cssPxValueText.length; i++) {

            // Stop search for valid numeric characters,  when a none numeric number is found.
            if (validChars.indexOf(cssPxValueText.charAt(i)) == -1) {

                // Start conversion if at least one character is valid.
                if (i > 0) {
                    // Convert validnumbers to int and return result.
                    convertedValue = parseInt(cssPxValueText.substring(0, i));
                    return convertedValue;
                }
            }
        }

        return convertedValue;
    };
     this.constructor=function(required_index)
     {
         //alert('constructor');
         that.slides.each(function(index,slide)
         {
             slide=$(slide);
             if(index>required_index+1)
             {
                 slide.find('span.title').addClass('orange_border');

             }

             //if(index==that.activeIndex && that.activeIndex>0)
             //{
             //    that
             //}

             if(that.activeIndex>=index) // prev, active
             {
                 slide.css({left:((index)*that.options.titleWidth)+'px'});
             }
             else if(that.activeIndex<index) // next
             {
                 slide.css({left:(index-1)*that.options.titleWidth+that.options.slideWidth+'px'});
             }
             slide.css({
                 width:that.options.sliderWidth,
                 height:that.sliderHeight
             });
             slide.find('img').css({
                 width:that.options.sliderWidth,
                 height:that.sliderHeight
             });
         });
     }
    this.destructor=function(required_index)
    {      //alert('destructor');
        that.slides.each(function(index,slide)
        {
            slide=$(slide);
            if(index>that.activeIndex)
            {
                slide.find('span.title').removeClass('orange_border');

            }
            //if(index==that.activeIndex && that.activeIndex>0)
            //{
            //    that
            //}

            if(that.activeIndex>=index) // prev, active
            {
                slide.css({left:(index)*that.options.titleWidth+'px'});
            }
            else if(that.activeIndex<index) // next
            {
                slide.css({left:(index-1)*that.options.titleWidth+that.options.slideWidth+'px'});
            }
            slide.css({
                width:that.options.slideWidth,
                height:that.sliderHeight
            });
            slide.find('img').css({
                width:that.options.slideWidth,
                height:that.sliderHeight
            });
        });
    }
    this.next=function()
    {
        if(that.activeIndex+1==that.slides.length)//last
        {
            that.showSlide(1,that.constructor,that.destructor);
        }
        else                                        //next
        {
            that.showSlide(that.activeIndex+2,that.constructor,that.destructor);
        }
    };
    this.init= function()
    {

        //alert(that.sliderHeight+'x'+that.sliderWidth);
        that.slides=that.slider.find('div.slide');
        that.slides_count=that.slides.length;
        that.activeIndex=that.options.position-1;
that.initPosition();

          that.constructor(that.activeIndex);

        that.slides.each(function(index,slide)
        {
            slide=$(slide);
            if(index==0)
            {
               // slide.find('span.title').css({marginLeft:'20px'});
            }

            if(that.activeIndex==index)
            {
                slide.addClass('active');
            }
            else if(that.activeIndex==index-1)
            {
                slide.addClass('next');
            }
            else if(that.activeIndex==index+1)
            {
                slide.addClass('previous');
            }




        });
        
       if(that.options.allowAuto===true)
       {
           that.timer_id=setInterval(that.next,that.options.timeout);
       }
        that.slider.resize(function()
        {
            that.initPosition();
        });
        this.bindClickHandler();
    };
    this.initPosition=function()
    {
        var sliderWidth=that.slider.outerWidth();

        that.options.slideWidth=that.slider.find('div.slide span.title').eq(0).outerHeight();
        //console.log('zxc:'+zxc);
        //that.slider.find('div.slide span.title').css('height',that.options.slideWidth+'px');
        //alert('sw:'+sliderWidth+';tsw:'+that.sliderWidth);
        //sliderWidth=that.ConvertCssPxToInt(sliderWidth);
        //sliderWidth=
        that.sliderWidth=sliderWidth;
        //alert(sliderWidth);
        var temp_slide=$('<span class="title"></span>').wrap('<div class="slide"></div>').parent().appendTo('#home-slider');
        var title_width=temp_slide.find('span.title').css('height');
        temp_slide.remove();
        that.options.titleWidth=ConvertCssPxToInt(title_width);
        console.log('title_width:'+that.options.titleWidth);
        that.options.slideWidth=sliderWidth-(that.slides.length-1)*that.options.titleWidth;
        that.sliderHeight=that.slider.outerHeight();
        //if(that.sliderHeight>$(window).height())
        //    that.sliderHeight=$(window).height();
        console.log('slider width:'+that.sliderWidth+';sliderHeight:'+that.sliderHeight+'slideWidth:'+that.options.slideWidth);

        that.slides.each(function(index,slide)
        {
            slide=$(slide);

            //if(index==that.activeIndex && that.activeIndex>0)
            //{
            //    that
            //}

            if(that.activeIndex>=index) // prev, active
            {
                slide.css({left:(index)*that.options.titleWidth+'px'});
            }
            else if(that.activeIndex<index) // next
            {
                slide.css({left:(index-1)*that.options.titleWidth+that.options.slideWidth+'px'});
            }
            slide.css({
                width:that.options.slideWidth+'px',
                height:that.sliderHeight+'px'
            });
            slide.find('img').css({
                width:that.options.slideWidth+'px',
                height:that.sliderHeight+'px'
            });
            slide.find('span').css({
                width:that.sliderHeight+'px',
                height:that.options.titleWidth+'px'
            })/*.position({top:0})*/;
            console.log('2>>>>>>>>slider width:'+that.sliderWidth+';sliderHeight:'+that.sliderHeight+'slideWidth:'+that.options.slideWidth);

        });
    };


    this.bindClickHandler=function()
    {
        that.slides.each(function(index,slide)
        {
            slide=$(slide);

            slide.find('span.title').click(function()
            {
                if(!slide.hasClass('active'))
                {
                    var clicked_title=$(this);
                    var new_index=clicked_title.parent().index();
                    that.showSlide(new_index+1,that.constructor,that.destructor);
                    if(that.timer_id!==false)
                        clearInterval(that.timer_id);
                    if(that.options.allowAuto)
                        that.timer_id=setInterval(that.next,that.options.timeout);
                }
            });
        });
    };

    this.initHeaderSize = function(){

    };



    this.showSlide= function(pos,constructor,destructor)
    {
        var required_index=pos-1;
        if(that.activeIndex!=required_index)
        {

            /* remove active flag */

            var active_slide=that.slider.find('div.slide.active');
            active_slide.removeClass('active');
            active_slide.next().removeClass('next');
            active_slide.prev().removeClass('previous');
            if(destructor)
                destructor(required_index);

            var required_slide=that.slides.eq(required_index);
            required_slide=$(required_slide);
            required_slide.addClass('active');
            required_slide.next().addClass('next');
            required_slide.prev().addClass('previous');
            if(constructor)
                constructor(required_index);

            if(required_index<=that.activeIndex) // prev  required
            {
                var elements=[];
                for(var i=required_index+1;i<=that.activeIndex;i++)
                {
                    that.slides.eq(i).animate({left:'+='+(that.options.slideWidth-that.options.titleWidth)},that.options.speed);
                }
            }
            else if(required_index>that.activeIndex) // next  required
            {
                var elements=[];
                for(var i=that.activeIndex+1;i<=required_index;i++)
                {
                    that.slides.eq(i).animate({left:'-='+(that.options.slideWidth-that.options.titleWidth)},that.options.speed);
                }
            }






        }
        that.activeIndex=required_index;
    };
    that.moveLeftBy=function(elements,px)
    {
        $(elements).each(function(index,element){
            var currentLeft=that.ConvertCssPxToInt(element.css('left'));
            element.css({left:currentLeft+px+'px'});
        });
    };



    //this.init();


    return this;
};
