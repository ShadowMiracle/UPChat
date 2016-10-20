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
//= require_tree .

var ready = function() {
  /**
   * When the send message link on our home page is clicked
   * send an ajax request to our rails app with the sender_id and
   * recipient_id
   */

  $('.sidebar-controller').click(function(e) {
    e.preventDefault();

    var target = $(this).data('sidebar');

    $.get("", function (data) {
        $('#chatbox_' + conversation_id).html(data);
    }, "html");
  });



  /**
   * Used to minimize the chatbox
   */

  $(document).on('click', '.toggleChatBox', function(e) {
    e.preventDefault();

    var id = $(this).data('cid');
    chatBox.toggleChatBoxGrowth(id);
  });

  /**
   * Used to close the chatbox
   */

  $(document).on('click', '.closeChat', function(e) {
    e.preventDefault();

    var id = $(this).data('cid');
    chatBox.close(id);
  });


  /**
   * Listen on keypress' in our chat textarea and call the
   * chatInputKey in chat.js for inspection
   */

  $(document).on('keydown', '.chatboxtextarea', function(event) {

    var id = $(this).data('cid');
    chatBox.checkInputKey(event, $(this), id);
  });

  /**
   * When a conversation link is clicked show up the respective
   * conversation chatbox
   */

  $('a.conversation').click(function(e) {
    e.preventDefault();

    var conversation_id = $(this).data('cid');
    chatBox.chatWith(conversation_id);
  });
}

$(document).ready(ready);
$(document).on("page:load", ready);
