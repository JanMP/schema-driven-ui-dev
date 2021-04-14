import {Meteor} from 'meteor/meteor'
import '/imports/api/api'
import React from 'react'
import {render} from 'react-dom'
import 'semantic-ui-css/semantic.min.css'
import 'react-virtualized/styles.css'
import 'react-toastify/dist/ReactToastify.min.css'
import 'react-big-calendar/lib/css/react-big-calendar.css'
import './main.styl'
import {App} from '/imports/ui/App'

Meteor.startup ->
  render <App/>, document.getElementById 'react-target'
