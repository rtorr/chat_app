// Generated by CoffeeScript 1.4.0
(function() {

  chat_app.service('chat_services', function() {
    var chat_posts;
    chat_posts = [];
    this.get_chat_posts = function() {
      return chat_posts;
    };
    socket.on('news', function(data) {
      return chat_posts = data;
    });
  });

}).call(this);
