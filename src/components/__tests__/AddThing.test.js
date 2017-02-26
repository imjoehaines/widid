import React from 'react'
import ReactDOM from 'react-dom'

import AddThing from '../AddThing'

global.it('renders without crashing', () => {
  const div = document.createElement('div')
  ReactDOM.render(<AddThing />, div)
})
