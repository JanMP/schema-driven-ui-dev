import {Meteor} from 'meteor/meteor'
import React from 'react'
import {render} from 'react-dom'
import 'semantic-ui-css/semantic.min.css'
import '/imports/api/api'
import {App} from '/imports/ui/App'

Meteor.startup ->
  render <App/>, document.getElementById 'react-target'
