// @flow

import React from 'react'

import Input from '../elements/Input'

type PropTypes = { newThing : string, onChange : string => void, onSubmit : SyntheticInputEvent => void }

export default ({ newThing, onChange, onSubmit } : PropTypes) =>
  <form onSubmit={onSubmit}>
    <Input
      type='text'
      value={newThing}
      onChange={event => onChange(event.target.value)}
      placeholder='&hellip;'
    />
  </form>
