#Get the token using basic authorization
app.post '/token', (req, res) ->

#Capture and decode base64 credentials
  cred = basicAuth req

  #Check that credentials were sent
  if !cred || !cred.name || !cred.pass
    res.send 'Invalid Login'

  #Authenticate user name and password here
  if(cred.name == 'Aladdin' && cred.pass = 'OpenSesame')

#Create the claim
    claim =
      "sub": cred.name
      "iss": 'localhost'
      "scope": ['public', 'my', 'admin'] #insert the proper scope

    #Create a token with an expiration date
    jwt = njwt.create claim, "secret", "HS512"
    jwt.setExpiration Date.now() + 60*60*5000 #5 hours from now
    jwt.compact()

    #Add the token to the header
    res.header 'token', jwt
    res.send 'Here have a token!'

#If authentication fails, send this message.
  else
    res.send 'Invalid log in'

  return