import React, { Component } from 'react'

import Body from './elements/Body'
import Heading from './elements/Heading'
import Container from './elements/Container'
import MainHeader from './elements/MainHeader'

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
      <Body>
        <Container>
          <Heading>
            <MainHeader>widid</MainHeader>

            <AddThing
              newThing={this.state.newThing}
              onChange={event => this.handleInput(event.target.value)}
              onSubmit={this.addNewThing}
            />
          </Heading>

          <main>
            <ThingList things={this.state.things} />
          </main>
        </Container>
      </Body>
    )
  }
}
