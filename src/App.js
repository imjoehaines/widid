import React, { Component } from 'react'

import Body from './elements/Body'
import Button from './elements/Button'
import Heading from './elements/Heading'
import Container from './elements/Container'
import MainHeader from './elements/MainHeader'

import AddThing from './components/AddThing'
import ThingList from './components/ThingList'

const sessionStorage = global.sessionStorage || { setItem () {}, getItem () {} }

export default class App extends Component {
  constructor () {
    super()

    this.state = {
      newThing: '',
      things: []
    }

    this.addNewThing = this.addNewThing.bind(this)
    this.clearThings = this.clearThings.bind(this)
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
    }, () => sessionStorage.setItem('state', JSON.stringify(this.state)))
  }

  clearThings () {
    this.setState({
      things: []
    }, () => sessionStorage.setItem('state', JSON.stringify(this.state)))
  }

  handleInput (newThing) {
    this.setState({ newThing })
  }

  componentWillMount () {
    try {
      const previousState = JSON.parse(sessionStorage.getItem('state'))

      if (!previousState) return

      this.setState(previousState)
    } catch (err) {
      return
    }
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

            {this.state.things.length > 0 && <Button onClick={this.clearThings}>Clear</Button>}
          </main>
        </Container>
      </Body>
    )
  }
}
