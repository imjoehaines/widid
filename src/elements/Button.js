import styled from 'styled-components'

import { primary, subtle } from '../colours'

export default styled.a`
  color: ${subtle};
  text-decoration: none;
  border-bottom: 1px solid ${subtle};

  &:active {
    color: ${primary};
    border-color: ${primary};
  }
`
