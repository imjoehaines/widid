import React from 'react'

import Time from '../elements/Time'
import Text from '../elements/Text'

export default thing =>
  <li key={thing.id}>
    <Text>
      {thing.text}
      <Time>{thing.time}</Time>
    </Text>
  </li>
