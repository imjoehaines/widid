import React from 'react'

import Time from '../elements/Time'
import Text from '../elements/Text'

export default ({ id, text, time }) =>
  <li key={id}>
    <Text>
      {text}
      <Time>{time}</Time>
    </Text>
  </li>
