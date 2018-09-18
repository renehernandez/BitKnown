document.addEventListener("DOMContentLoaded", function(event) {
    // required: replace example with your forum shortname
    if(disqus_shortname && typeof disqus_shortname === "string") {
        var disqus_identifier = document.getElementById('single-post-id').innerText;

        /* * * DON'T EDIT BELOW THIS LINE * * */
        (function() {
        var dsq = document.createElement('script'); dsq.type = 'text/javascript'; dsq.async = true;
        dsq.src = '//' + disqus_shortname + '.disqus.com/embed.js';
        (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(dsq);
        })();
    }
});