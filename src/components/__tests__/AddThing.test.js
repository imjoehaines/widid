import React from 'react'
import ReactDOM from 'react-dom'

import AddThing from '../AddThing'
import store from '../../store'

global.it('renders without crashing', () => {
  const div = document.createElement('div')
  ReactDOM.render(<AddThing store={store} />, div)
})
