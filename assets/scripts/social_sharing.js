jQuery(document).ready(function($) {
    $sharingData = {}; 
    $sharingData.title = $('.sharingData-title').text();
    $sharingData.url = $('.sharingData-url').text();

    $('.rrssb-buttons').rrssb({
        // required:
        title: $sharingData.title,
        url: $sharingData.url,

        // optional:
         description: $sharingData.title,
        // emailBody: 'Usually email body is just the description + url, but you can customize it if you want'
    });
});