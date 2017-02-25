import React from 'react'

import Time from '../elements/Time'

export default thing =>
  <li key={thing.id}>{thing.text} <Time>{thing.time}</Time></li>
