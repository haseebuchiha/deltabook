import consumer from "./consumer"

consumer.subscriptions.create("ChatroomChannel", {
  connected() {
  },

  disconnected() {
  },

  received(data) {
    $('#msg').append(data.mod_msg)

    if ($('#msg').length > 0) {
      $('#msg').scrollTop($('#msg')[0].scrollHeight);
    }
  },


});
