import React from 'react'
import {AppRouter} from 'meteor/janmp:schema-driven-ui'
import menuDefinitions from './menuDefinitions'


export App = ->
  <AppRouter menuDefinitions={menuDefinitions}/>
