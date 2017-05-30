// @flow

import React from 'react'

import List from '../elements/List'

import Thing from './Thing'

import type ThingType from '../types'

type PropTypes = { things : Array<ThingType> }

export default ({ things } : PropTypes) =>
  <List>
    {things.map(Thing)}
  </List>
