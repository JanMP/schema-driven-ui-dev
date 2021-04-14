import React from 'react'
import {Icon, Label, Menu} from 'semantic-ui-react'

export default TestMenuItem = ->
  <Menu.Menu position='right' style={width: '5rem'}>
   <div style={alignItems: 'end'}>
     <Label>
       <Icon name='mail'/>123
     </Label>
   </div>
  </Menu.Menu>