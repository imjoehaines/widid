const express = require('express')
const db = require('sqlite')
const path = require('path')

const app = express()

app.use(express.static(path.resolve(__dirname, 'public')))

app.get('/things', async (request, response, next) => {
  const things = await db.all(`SELECT "text", CAST(strftime("%s", date_created) AS INT) AS time FROM thing`)

  response.send(things)
})

Promise.resolve()
.then(() => db.open('./db.sq3'))
.then(() => db.migrate(process.env.APP_ENV !== 'production' && { force: 'last' }))
.then(() => app.listen(3000))
.catch(err => console.error(err))
