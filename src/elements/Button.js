import styled from 'styled-components'

import { primary, subtle } from '../colours'

export default styled.a`
  color: ${subtle};
  text-decoration: none;
  border-bottom: 1px solid ${subtle};
  transition: border-bottom-color 0.25s ease-in-out;

  &:hover {
    border-bottom-color: ${primary};
  }

  &:active {
    color: ${primary};
    border-bottom-color: ${primary};
  }
`
