express = require 'express'
basicAuth = require 'basic-auth'
njwt = require 'njwt'
app = express()

#Get the token using basic authorization
app.post '/token', (req, res) ->

  cred = basicAuth req

  if !cred || !cred.name || !cred.pass
    res.send 'Invalid Login'

  if(cred.name == 'Aladdin' && cred.pass = 'OpenSesame')

    claim =
      "sub": cred.name
      "iss": 'localhost'
      "scope": ['public', 'my', 'admin']

    jwt = njwt.create claim, "secret", "HS512"
    jwt.setExpiration Date.now() + 60*60*5000 #5 hours from now
    jwt.compact()

    res.header 'token', jwt
    res.send 'Here have a token!'

  else
    res.send 'Invalid log in'

  return

#Send a token using bearer authorization, to access a resource.
app.get '/resource', (req, res) ->

  token = req.headers.authorization.split(' ')[1]

  if(token)
    njwt.verify token, "secret", "HS512", (err, jwtPkg) ->
      if(err)
        res.send 'Invalid Permissions'
      else
        console.log jwtPkg
        res.send 'Here is your resource'

  else
    res.send 'Invalid Permissions'

  return

#Setup the server to listen on port 8081 on the localhost
server = app.listen 8081, 'localhost', ->
  host = server.address().address
  port = server.address().port

  console.log 'This app is listening on http://%s:%s', host, port
  return