import React from 'react'

export default ({ newThing, onChange, onSubmit }) =>
  <div>
    <form onSubmit={onSubmit}>
      <label>
        Add a thing
        <input
          type='text'
          value={newThing}
          onChange={onChange}
        />
      </label>

      <button>Add</button>
    </form>
  </div>
