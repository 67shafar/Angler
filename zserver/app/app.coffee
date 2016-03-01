express = require 'express'
basicAuth = require 'basic-auth'
njwt = require 'njwt'
lib = require './lib'

app = express()

#Setup the server to listen on port 8081 on the localhost
server = app.listen 8081, 'localhost', ->
  host = server.address().address
  port = server.address().port

  console.log 'This app is listening on http://%s:%s', host, port
  return