// @flow

import React from 'react'
import { connect } from 'react-redux'

import Body from './elements/Body'
import Button from './elements/Button'
import Heading from './elements/Heading'
import Container from './elements/Container'
import MainHeader from './elements/MainHeader'

import AddThing from './components/AddThing'
import ThingList from './components/ThingList'

const App = ({ things, clearThings }) =>
  <Body>
    <Container>
      <Heading>
        <MainHeader>widid</MainHeader>

        <AddThing />
      </Heading>

      <main>
        <ThingList />

        {things.length > 0 &&
          <Button href='#' onClick={event => { event.preventDefault(); clearThings() }}>Clear list</Button>
        }
      </main>
    </Container>
  </Body>

const mapStateToProps = state => ({
  things: state.things
})

const mapDispatchToProps = dispatch => ({
  clearThings: () => dispatch({ type: 'CLEAR_THINGS' })
})

export default connect(mapStateToProps, mapDispatchToProps)(App)
