import consumer from "./consumer"

const ChatroomChannel = consumer.subscriptions.create("ChatroomChannel", {
  connected() {
    console.log("connected...")
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // console.log(data.mod_msg)
    // $('#msg').append(data.mod_msg)
    // if ($('#msg').length > 0) {
    //   $('#msg').scrollTop($('#msg')[0].scrollHeight);
    // }
    // Called when there's incoming data on the websocket for this channel
  }, 
});

export default ChatroomChannel
