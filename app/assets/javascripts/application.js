// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require turbolinks
//= require private_pub
//= require_tree .

var ready = function() {
  /**
   * When the send message link on our home page is clicked
   * send an ajax request to our rails app with the sender_id and
   * recipient_id
   */

  $('#sendmessage input').focus(function(e) {
    var conversation_id = $('#sendmessage').data('conversation');
    console.log(conversation_id)

    if (conversation_id) {
      $.ajax({
        type: "POST",
        url: "/conversations/mark_as_read",
        data: { id: conversation_id},
        success: function(data) {
        }
      });

      $(".unread").removeClass("unread");
      $("#conversation-" + conversation_id).find(".badge").html('');
    }
  });
}

$(document).ready(ready);
$(document).on("page:load", ready);
