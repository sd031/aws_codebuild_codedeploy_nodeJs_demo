const express = require('express')
const app = express()
const port = 3000;
const config = require('config')
console.log(config);

app.get('/', (req, res) => {
  res.send('CodeDeploy Sample V4!')
})

app.get('/status', (req, res) => {
    res.send('ok')
  })
app.get('/check_configuration', (req, res) => {
    res.json(config)
  })
app.listen(port, () => {
  console.log(`Example app listening at http://localhost:${port}`)
})