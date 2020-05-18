import React from 'react'
import {MeteorDataAutoTable} from 'meteor/janmp:schema-driven-ui'
import {props} from '/imports/api/AutoTableTest.coffee'

export default AutoTableTest = ->
  
  <MeteorDataAutoTable {{query: {}, props...}...}/>
