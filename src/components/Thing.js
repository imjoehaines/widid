// @flow

import React from 'react'

import Time from '../elements/Time'
import Text from '../elements/Text'

import type ThingType from '../types'

export default ({ id, text, time } : ThingType) =>
  <li key={id}>
    <Text>
      {text}
      <Time>{time}</Time>
    </Text>
  </li>
