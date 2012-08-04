express = require('express')
stylus = require('stylus')
assets = require('connect-assets')

app = express()
app.use assets()
app.use express.bodyParser()
app.set 'view engine', 'jade'

app.get('/', (req, res) ->
  return res.render('index')
)

#app.listen(port, () ->
#  return console.log("Listening on " + port + "\nPress CTRL-C to stop server.")
#)

#port = process.env.PORT || process.env.VMC_APP_PORT || 3000
app.listen 3000
