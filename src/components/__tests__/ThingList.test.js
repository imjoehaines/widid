import React from 'react'
import ReactDOM from 'react-dom'

import ThingList from '../ThingList'
import store from '../../store'

global.it('renders without crashing', () => {
  const div = document.createElement('div')
  ReactDOM.render(<ThingList things={[]} store={store} />, div)
})
