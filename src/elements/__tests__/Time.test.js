import React from 'react'
import ReactDOM from 'react-dom'

import Time from '../Time'

global.it('renders without crashing', () => {
  const div = document.createElement('div')
  ReactDOM.render(<Time />, div)
})
