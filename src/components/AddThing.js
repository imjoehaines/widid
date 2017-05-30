import React from 'react'

import Input from '../elements/Input'

export default ({ newThing, onChange, onSubmit }) =>
  <form onSubmit={onSubmit}>
    <Input
      type='text'
      value={newThing}
      onChange={event => onChange(event.target.value)}
      placeholder='&hellip;'
    />
  </form>
