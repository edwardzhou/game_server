# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

@dispatcher = null
myself = @

@success_response = (resp) ->
  console.log "success: #{JSON.stringify(resp)}"

@failure_response = (resp) ->
  console.log "failure: #{JSON.stringify(resp)}"

jQuery ->
  myself.dispatcher = new WebSocketRails("localhost:3000/websocket")

  myself.dispatcher.on_open = (data) ->
    console.log "connection has been established: #{JSON.stringify(data)}"

  myself.dispatcher.bind("connection_closed", (data) ->
    console.log "connection has been closed: #{JSON.stringify(data)}"
  )

  myself.dispatcher.bind "sessions.new_login", (data) ->
    console.log "sessions.new_login: #{JSON.stringify(data)}"

  myself.dispatcher.bind "sessions.user_logout", (data) ->
    console.log "sessions.user_logout: #{JSON.stringify(data)}"

  myself.dispatcher.on_message = (data) ->
    console.log "on_message: #{JSON.stringify(data)}"

  console.log "jquery-> #{@}"
  user = {username: "edwardzhou1", password: "123456"}



  myself.dispatcher.trigger("sessions.sign_up", user, myself.success_response, myself.failure_response )

console.log "outside -> #{@}"
