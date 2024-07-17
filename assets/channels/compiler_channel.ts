import consumer from "./consumer";

consumer.subscriptions.create(
  { channel: "ViewComponentUI::CompilerChannel" },
  {
    received: () => {
      console.log("[INFO] Received a message from compiler channel");
      location.reload();
    },
    connected: () => {
      console.log("[INFO] Connected to the compiler channel");
    },
  }
);
