import React, { Component } from 'react'

import AddThing from './components/AddThing'
import ThingList from './components/ThingList'

export default class App extends Component {
  constructor () {
    super()

    this.state = {
      newThing: '',
      things: []
    }

    this.addNewThing = this.addNewThing.bind(this)
  }

  addNewThing (event) {
    event.preventDefault()

    if (this.state.newThing.trim() === '') return

    const newThing = {
      text: this.state.newThing,
      id: this.state.things.length + 1,
      time: new Date().toTimeString().slice(0, 5)
    }

    this.setState({
      things: this.state.things.concat([newThing]),
      newThing: ''
    })
  }

  handleInput (newThing) {
    this.setState({ newThing })
  }

  render () {
    return (
      <div>
        <heading>
          <h1>widid</h1>

          <AddThing
            newThing={this.state.newThing}
            onChange={event => this.handleInput(event.target.value)}
            onSubmit={this.addNewThing}
          />
        </heading>

        <main>
          <ThingList things={this.state.things} />
        </main>
      </div>
    )
  }
}
