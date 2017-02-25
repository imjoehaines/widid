import styled from 'styled-components'

import { primary, text, subtle } from '../colours'

export default styled.input`
  font-size: 1.1rem;
  font-weight: lighter;
  padding: 0.25rem 0;
  background: none;
  border: none;
  border-bottom: 1px solid ${subtle};
  color: ${text};
  width: 100%;
  transition: border-bottom-color 0.25s ease-in-out;

  &:focus {
    outline: none;
    border-bottom-color: ${primary};
  }

  &::-webkit-input-placeholder {
    color: ${subtle};
  }
`
