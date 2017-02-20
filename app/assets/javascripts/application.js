// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery-fileupload/basic
//= require turbolinks
//= require_tree .
$(function() {
  $('#phone_search').submit(function () {
    $.get(this.action, $(this).serialize(), null, 'script');
    return false;
  });
});

// http://stackoverflow.com/questions/34225162/flash-messages-how-to-show-them-properly-rails-js
$(function() {
  $('#flashes').delay(3000).fadeOut(800);
});

// $(function() {
//   $('#fileupload').fileupload({
//         dataType: 'json',
//         done: function (e, data) {
//             data.context.text('Upload finished.');
//         },
//         progressall: function (e, data) {
//           var progress = parseInt(data.loaded / data.total * 100, 10);
//           $('#progress .bar').css(
//               'width',
//               progress + '%'
//             );
//         }
//   })
// });