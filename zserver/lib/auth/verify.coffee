#Send a token using bearer authorization, to access a resource.
verify = (req, res) ->

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
