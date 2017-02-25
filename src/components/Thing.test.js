import React from 'react'
import ReactDOM from 'react-dom'

import Thing from './Thing'

global.it('renders without crashing', () => {
  const div = document.createElement('div')
  ReactDOM.render(<Thing />, div)
})
