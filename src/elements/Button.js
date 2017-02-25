import styled from 'styled-components'

import { primary, subtle } from '../colours'

export default styled.button`
  background: ${subtle};
  border: 1px solid ${subtle};
  color: #fff;

  &:active {
    background: ${primary};
    border-color: ${primary};
  }

  &:focus {
    border-color: ${primary};
    outline: none;
  }
`
