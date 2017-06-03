import { createStore } from 'redux'

const initialState = {
  newThing: '',
  things: []
}

const reducer = (state = initialState, action) => {
  switch (action.type) {
    case 'INPUT':
      return { ...state, newThing: action.input }

    case 'ADD_THING':
     const newThing = {
        text: state.newThing,
        id: state.things.length + 1,
        time: action.date.toTimeString().slice(0, 5)
      }

      return { ...state, newThing: '', things: state.things.concat(newThing) }

    case 'CLEAR_THINGS':
      return { ...state, things: [] }

    default:
      return state
  }
}

export default createStore(reducer)
