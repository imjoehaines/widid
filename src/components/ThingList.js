import React from 'react'

import List from '../elements/List'

import Thing from './Thing'

export default ({ things }) =>
  <List>
    {things.map(Thing)}
  </List>
