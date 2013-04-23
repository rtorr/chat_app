

chat_app.controller 'PostsController', ($scope, chat_services) ->

  init = ->
    socket.emit('init', 'init-data')

  $scope.insert_post = ->
    new_post = $scope.newPost
    socket_the_data new_post
    new_post.post_text = ""
    return

  socket_the_data = (data) ->
    socket.emit('new_post', data)

  socket.on 'news', () ->
    $post_container = $('#posts')

    $scope.$apply(->
      $scope.posts = chat_services.get_chat_posts()
    );

    post_container_scroll_eight = document.getElementById('posts').scrollHeight;
    $post_container.animate({scrollTop: post_container_scroll_eight});
    return

  init()