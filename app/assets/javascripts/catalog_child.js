function openChild(url){
    var menu_link=$('.catalog-item>ul>li>a[href*="'+url+'"]');
    var $tab=$('#tab-control .tabs .tab-item a[href*="'+url+'"]').parent();
    var $tabs=$tab.parent().find('.tab-item');
    console.log('required:'+url);
    $.ajax({
        url:url+'.xml',
        dataType:'xml',
        success:function(xml){
            var $xml=$(xml);
            x=$xml;
            var description=$('child_info child_description',$xml).text();
            var $description=$('<div></div>');
            $description.addClass('description');
            var $products=$('<div></div>');

            var $tab_content=$('<div></div>');

            $products.attr('id','all-products-by-childs');
            var $store_section=$('<div></div>');
            $store_section.addClass('store-section');
            $products.append($store_section);
            var $top_border=$('<div></div>');
            $top_border.addClass('top-border');
            $store_section.append($top_border);

            $('products_by_child product',$xml).each(function(index,item){
                var $xml_item=$(item);
                var product_name=$('product_name',$xml_item).text();
                var product_description=$('product_description',$xml_item).text();
                var product_avatar=$('product_avatar',$xml_item).text();
                var product_slug=$('product_slug',$xml_item).text();

                var $item=$('<div></div>');
                $item.addClass('online-item');
                var $img=$('<img />');
                $img.attr('src',product_avatar);
                $img.attr('alt',product_name);
                var $title=$('<p>'+product_name+'</p>');
                var $show_more=$('<a>Детальніше</a>');
                $show_more.attr('href',product_slug);
                $show_more.addClass('submit-branded');
                $show_more.addClass('animate');
                $show_more.attr('title',product_name);

                $item.append($img);
                $item.append($title);
                $item.append($show_more);

                $store_section.append($item);
            });

            if(description!='')
                $description.append(description);
            else
                $description.append('<p>page is empty</p>');

            //$('#all-products-by-childs').remove()
            $tab_content.append($description);
            $tab_content.append($products);

            $('#tabcontents .tab-content-wrapper').html($tab_content);
            //var $catalog_content=$('div#catalog-content');
            //var $catalog_parent=$catalog_content.find('div#catalog-parent');

            $tabs.filter('.active').removeClass('active');
            $tab.addClass('active');

            $('div.catalog-block').find('a.active').removeClass('active');
            $('div.catalog-block').find('a[href*="'+url+'"]').addClass('active');

            // add url handler


        }
    });
}
window.onpopstate = function(event) {
    return;
    console.log("location: " + document.location + ", state: " + JSON.stringify(event.state)+';window.location.pathname:'+window.location.pathname);
    var url=window.location.pathname;
    if(event.state=='child'){
        openChild(url);

    }
};
$document.on("click", "#tab-control .tabs .tab-item a", function(event){
    return;
    event.preventDefault();
    var uri=$(this).uri();
    var required_uri=uri.pathname();
    openChild(required_uri);
    window.history.pushState('child','',required_uri);
});
$(document).on("click", "div.catalog-block div.catalog-item>ul>li>ul>li>a", function(event){
    return;
    event.preventDefault();
    var uri=$(this).uri();
    var required_uri=uri.pathname();
    //alert(required_uri);
    openChild(required_uri);
    window.history.pushState('child','',required_uri);
});