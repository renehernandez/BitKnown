jQuery(document).ready(function($) {
    $('.rrssb-buttons').rrssb({
        // required:
        title: '{{post.title}}',
        url: '{{@blog.url}}{{post.url}}',

        // optional:
         description: '{{post.title}}',
        // emailBody: 'Usually email body is just the description + url, but you can customize it if you want'
    });
});