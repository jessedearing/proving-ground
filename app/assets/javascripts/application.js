// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

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

