if(window.social_link){
    var url_regexp = /^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$/
    $.each(window.social_link,function(type, url){
        if(typeof url ==="string" && url_regexp.test(url)){
            $('<li>').append($('<a>',{
                                html: '<i class="fab fa-'+type+'"></i>',
                                title: type,
                                href: url,
                                target: "_blank"
                            })
                        ).appendTo('.social_link');

        }
    })
}