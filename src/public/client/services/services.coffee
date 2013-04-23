
chat_app.service 'chat_services', ->

  chat_posts = []

  @get_chat_posts = ->
    return chat_posts

  socket.on 'news', (data) ->
    chat_posts = data

  return