import {Meteor} from 'meteor/meteor'
import '/imports/api/api'
import React from 'react'
import {render} from 'react-dom'
import {App} from '/imports/ui/App'

Meteor.startup ->
  render <App/>, document.getElementById 'react-target'
