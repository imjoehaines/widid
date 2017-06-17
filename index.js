const bodyParser = require('body-parser')
const express = require('express')
const db = require('sqlite')
const path = require('path')

const app = express()

app.use(bodyParser.json())
app.use(express.static(path.resolve(__dirname, 'public')))

app.get('/things', async (request, response, next) => {
  const things = await db.all(
    `SELECT id, "text", CAST(strftime("%s", date_created) AS INT) AS time
    FROM thing
    ORDER BY date_created DESC`
  )

  response.json(things)
})

app.delete('/things/:thingId', async (request, response, next) => {
  const { thingId } = request.params

  await db.run('DELETE FROM thing WHERE id = $thingId', { $thingId: thingId })

  response.json({ id: +thingId })
})

app.post('/things', async (request, response, next) => {
  const { text } = request.body

  const { lastID: id } = await db.run('INSERT INTO thing (text, date_created) VALUES ($text, CURRENT_TIMESTAMP)', { $text: text })
  const thing = await db.get(
    `SELECT id, "text", CAST(strftime("%s", date_created) AS INT) AS time
     FROM thing
     WHERE id = $id`,
     { $id: id }
  )

  response.json(thing)
})

Promise.resolve()
.then(() => db.open('./db.sq3'))
.then(() => db.migrate(process.env.APP_ENV !== 'production' && { force: 'last' }))
.then(() => app.listen(3000))
.catch(err => console.error(err))
