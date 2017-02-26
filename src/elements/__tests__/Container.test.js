import React from 'react'
import ReactDOM from 'react-dom'

import Container from '../Container'

global.it('renders without crashing', () => {
  const div = document.createElement('div')
  ReactDOM.render(<Container />, div)
})
