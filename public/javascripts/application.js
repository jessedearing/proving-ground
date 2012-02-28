var JD = (function ($, window, nil) {
  return {
    new_comment: (function(node_id) {
    $.ajax({
      url: '/nodes/' + node_id + '/comments/new',
      success: function(data) {
        $('#comment_new').html(data).show('blind');
      },
      dataType: 'html'
    });
  }),
  edit_comment: (function(node_id, comment_id) {
    $.ajax({
      url: '/nodes/' + node_id + '/comments/' + comment_id + '/edit',
      success: function(data) {
        $('#comment_new').html(data).show();
      },
      dataType: 'html'
    });
  }),
  get_comments: (function(node_id) {
    $.ajax({
      url: '/nodes/' + node_id + '/comments',
      success: function(data) {
        $('#comments_container').html(data);
      },
      dataType: 'html'
    });
  })
  }
})(jQuery, this);
