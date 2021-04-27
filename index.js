const express = require('express')
const app = express()
const port = process.env.PORT || 3000 ;
const config = require('config')
console.log(config);

app.get('/', (req, res) => {
  res.send('CICD App V3!')
})

app.get('/status', (req, res) => {
    res.send('ok')
  })

  app.get('/check-env', (req, res) => {
    res.json({
      DB_NAME : process.env.DB_NAME,
      DB_USER: process.env.DB_USER,
      DB_HOST: process.env.DB_HOST
    })
  })

app.listen(port, () => {
  console.log(`Example app listening at http://localhost:${port}`)
})