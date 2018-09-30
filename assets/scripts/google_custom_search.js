function executeQuery(target) {
    var input = document.getElementById('cse-search-input-box-id');
    var element = google.search.cse.element.getElement('searchresults-only0');
    if (input.value == '') {
        element.clearAllResults();
    } else {
        element.execute(input.value);
    }
    return false;
}

document.addEventListener("DOMContentLoaded", function(event) { 
    document.getElementById('cse-search-box-form-id').addEventListener('submit', function(event) {
        return executeQuery();
    });

    (function() {
        var cx = window.custom_search.engine_id;
        var gcse = document.createElement('script');
        gcse.type = 'text/javascript';
        gcse.async = true;
        gcse.src = 'https://cse.google.com/cse.js?cx=' + cx;
        var s = document.getElementsByTagName('script')[0];
        s.parentNode.insertBefore(gcse, s);
    })();
});



