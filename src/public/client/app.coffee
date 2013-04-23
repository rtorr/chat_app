
window.chat_app = angular.module 'chat_app', []
window.socket = io.connect 'http://rtorr.local:3000'

chat_app.config ($routeProvider) ->
  $routeProvider
    .when '/'
      controller: 'PostsController'
      templateUrl: 'partials/posts.html'