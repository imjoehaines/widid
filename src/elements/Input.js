import styled from 'styled-components'

import { primary, subtle } from '../colours'

export default styled.input`
  font-size: 1.5rem;
  padding: 0.25rem 0.5rem;
  background: none;
  border: none;
  border-bottom: 1px solid ${subtle};
  color: ${primary};
  width: 100%;

  &:focus {
    outline: none;
    border-bottom-color: ${primary};
  }

  &::-webkit-input-placeholder {
    color: ${subtle};
  }
`
