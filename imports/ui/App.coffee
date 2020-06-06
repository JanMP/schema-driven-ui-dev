import React from 'react'
import {AppRouter} from 'meteor/janmp:schema-driven-ui'
import menuDefinitions from './menuDefinitions'
import TestMenuItem from './TestMenuItem'

export App = ->
  <AppRouter menuDefinitions={menuDefinitions} rightMenuItems={TestMenuItem}/>
