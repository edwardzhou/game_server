# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

@dispatcher = null
myself = @

@success_response = (resp) ->
  console.log "success: #{resp.user}"

@failure_response = (resp) ->
  console.log "failure: #{resp.error_message}"

jQuery ->
  myself.dispatcher = new WebSocketRails("localhost:3000/websocket")

  myself.dispatcher.on_open = (data) ->
    console.log "connection has been established: #{data}"

  myself.dispatcher.on_message = (data) ->
    console.log "on_message: #{data}"

  console.log "jquery-> #{@}"
  user = {username: "edwardzhou1", password: "123456"}



  myself.dispatcher.trigger("session.sign_up", user, @success_response, @-
  failure_response )

console.log "outside -> #{@}"
