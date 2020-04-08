import consumer from "./consumer";
import Bell from '../packs/bell';

function wrapParseBlock(data){
  let col = document.createElement("div");
  col.classList.add("col-md-6");
  col.classList.add("col-lg-6");
  col.classList.add("col-xl-4");
  col.innerHTML = data.content;
  console.log(data);
  let row = $(".parse-items");
  $(col).fadeOut();
  $(row).prepend(col);
  $(col).fadeIn();
}

consumer.subscriptions.create({ channel: "NotificationChannel", room: "batya room"}, {
  connected() {
    console.debug("Connected to channel");
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    wrapParseBlock(data);
    let bell = new Bell();
    bell.increase();
    bell.update();
  }
});
