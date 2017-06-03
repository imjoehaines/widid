// @flow

import React from 'react'
import { connect } from 'react-redux'

import Input from '../elements/Input'

type PropTypes = { newThing : string, onChange : string => void, onSubmit : Date => void }

const AddThing = ({ newThing, onChange, onSubmit } : PropTypes) =>
  <form onSubmit={event => { event.preventDefault(); onSubmit(new Date()) }}>
    <Input
      type='text'
      value={newThing}
      onChange={event => onChange(event.target.value)}
      placeholder='&hellip;'
    />
  </form>

const mapStateToProps = state => ({
  newThing: state.newThing
})

const mapDispatchToProps = dispatch => ({
  onChange: input => dispatch({ type: 'INPUT', input }),
  onSubmit: date => dispatch({ type: 'ADD_THING', date })
})

export default connect(mapStateToProps, mapDispatchToProps)(AddThing)
