$(document).ready(function(){

    $('div.catalog-block div.catalog-item>ul>li').each(function(){
        var $li=$(this);
        var url=$li.find('a').get(0).href+'.xml';
        if($li.find('ul').length==0){
            $.ajax({
                url:url,
                success:function(xml){

                    var $response=$(xml);
                    var $children=$response.find('childs_of_this_parent child');
                    var $parent=$response.find('parent_catalog_info');
                    if($parent.length==0){

                    }
                    if($children.length>0){
                        var ul=$('<ul></ul>');
                        var child_id;
                        var $span=$('<span></span>');
                        $children.each(function(childIndex,child){
                            var url=$('child_catalog_url',child).text();
                            var id=$('child_catalog_id',child).text()*1;
                            child_id=id;
                            var name=$('child_catalog_name',child).text();
                            ul.append('<li><a href="'+url+'">'+name+'</a></li>');

                        });

                        var $parent=$response.find('parent_catalog_info');
                        var parent_id;
                        if($parent.length==1){
                            var id=$('parent_catalog_id',$parent).text()*1;
                            parent_id=id;
                            $span.addClass('sub-menu-status');
                            $span.attr('id','sub-status-'+id);
                            $span.attr('data-opened','false');

                        }
                        ul.addClass('sub-status-ul-'+parent_id);

                        $li.append($span);
                        $li.append(ul);


                        $("#sub-status-"+parent_id).text("+");
                        //$('.sub-status-ul-'+parent_id).show();
                        $("#sub-status-"+parent_id).click(function(){
                            $('.sub-status-ul-'+parent_id).slideToggle('slow', function() {
                                // Animation complete.
                            });
                            $(this).each(function (i) {
                                if($(this).text() != "-"){
                                    $(this).text("-");
                                }else{
                                    $(this).text("+");
                                }
                            });
                        });

                    }
                    else{
                        //alert(0);
                    }

                }
            });
        }
    });


    function getCurrentLocation(){
        var str='';
        function getString(variable){
            var str='';
            if(typeof str == 'array'){
                for(var i=0;i<variable.length;i++){
                    if(typeof variable[i] == 'array'){
                        str+=getString(variable[i]);
                    }
                    else{
                        str+=variable[i];
                    }
                }
            }
            else{
                str=variable;
            }
            return variable;
        }
        var variable=window.location.hash;
        var str=getString(variable);
        var pathname_array=location.pathname.split('/');
        pathname_array.shift();
        if(pathname_array[0]=='catalog'){
            console.log('location:'+'catalog');
            $('.catalog-item>ul>li>a').click(function(event){
                //event.preventDefault();
                //this.css('background','red');
                //alert('hello');
                console.log('href:'+this.href.protocol);
                //$.ajax();
                var uri=$(this).uri();
                var required_uri=uri.pathname(true);
                console.log('required:'+required_uri);
                $.ajax({
                    url:required_uri+'.xml',
                    dataType:'xml',
                    success:function(xml){
                        var $xml=$(xml);
                        $('childs_of_this_parent>child',$xml).each(function(index,item){
                            //alert(index);
                            var $catalog_content=$('div#catalog-content');
                            var $catalog_parent=$catalog_content.find('div#catalog-parent');
                            //if($catalog_parent.length==1){ //if exists
                            //  catalog_parent.find('tab-wrapper')

                            //}
                        });
                    }
                });
            });
        }

    }
    getCurrentLocation();


});