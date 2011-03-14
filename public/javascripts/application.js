var JD = (function ($, window, nil) {
    $('#comment_new_link').click(function() {
    $.get(window.location.href + '/comments/new', function(data) {
      $('#comment_new').html(data).show('scale');
    });
    return false;
  });
})(jQuery, this);
