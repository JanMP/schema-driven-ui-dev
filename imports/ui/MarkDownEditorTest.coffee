import React, {useState, useEffect, useRef} from "react"
import {MarkDownEditor} from 'meteor/janmp:schema-driven-ui'
import {Editor} from '../api/Editor'
import {useTracker} from 'meteor/react-meteor-data'
import {meteorApply} from 'meteor/janmp:schema-driven-ui'
import _ from 'lodash'


# toolbar =
#   <div style={flex: "1 1 30px", padding: '3px'} ><button onClick={-> console.log 'fnord'}>fnord</button></div>

export default MarkDownEditorTest = ->

  useTracker ->
    handle = Meteor.subscribe 'editor'
    not handle.ready()
  , []

  value = useTracker -> Editor.findOne()?.value ? 'kein Text'

  setValue = (newValue) ->
    meteorApply
      method: 'editor.set'
      data: value: newValue

  <div style={height: '100%', display: 'flex', flexDirection: 'column'}>
    <MarkDownEditor
      value={value}
      onChange={setValue}
      mayEdit={true}
    />
  </div>