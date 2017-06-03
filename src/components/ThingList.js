// @flow

import React from 'react'
import { connect } from 'react-redux'

import List from '../elements/List'

import Thing from './Thing'

import type ThingType from '../types'

type PropTypes = { things : Array<ThingType> }

const ThingList = ({ things } : PropTypes) =>
  <List>
    {things.map(Thing)}
  </List>

const mapStateToProps = state => ({
  things: state.things
})

export default connect(mapStateToProps)(ThingList)
