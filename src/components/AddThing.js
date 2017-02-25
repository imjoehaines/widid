import React from 'react'

import Input from '../elements/Input'

export default ({ newThing, onChange, onSubmit }) =>
  <div>
    <form onSubmit={onSubmit}>
      <Input
        type='text'
        value={newThing}
        onChange={onChange}
        placeholder='&hellip;'
      />
    </form>
  </div>
