import React from 'react'

import Thing from './Thing'

export default ({ things }) =>
  <ul>
    {things.map(Thing)}
  </ul>
