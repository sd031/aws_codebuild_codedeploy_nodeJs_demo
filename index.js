const express = require('express')
const app = express()
const port = 3000;
const config = require('config')
console.log(config);

app.get('/', (req, res) => {
  res.send('CodeDeploy Sample v2!')
})

app.get('/status', (req, res) => {
    res.send('ok')
  })

app.listen(port, () => {
  console.log(`Example app listening at http://localhost:${port}`)
})