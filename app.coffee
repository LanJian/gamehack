express = require('express')
stylus = require('stylus')
assets = require('connect-assets')

app = express()
app.use assets()
app.use express.bodyParser()
app.use express.static "#{__dirname}/assets"
app.set 'view engine', 'jade'

app.get('/', (req, res) ->
  return res.render('index')
)

app.listen 3000
console.log "Listening on port 3000"
