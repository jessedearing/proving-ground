var JD = (function ($, window, nil) {
    $('#comment_new_link').click(function() {
    $.ajax({
      url: window.location.href + '/comments/new', 
      success: function(data) {
      $('#comment_new').html(data).show('blind');
      },
      dataType: 'html'
    });
    return false;
  });
})(jQuery, this);
