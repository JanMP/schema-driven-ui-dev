import React from 'react'
import {Container} from 'semantic-ui-react'
import MeteorDataAutoTable from 'meteor/janmp:schema-driven-ui'
import {props} from '/imports/api/AutoTableTest.coffee'

export default AutoTableTest = ->
  <Container>
    <MeteorDataAutoTable {{query: {}, props...}...}/>
  </Container>