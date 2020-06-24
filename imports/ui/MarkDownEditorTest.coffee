import React, {useState, useEffect, useRef} from "react"
import {MarkDownEditor} from 'meteor/janmp:schema-driven-ui'
import {Editor} from '../api/Editor'
import {useTracker} from 'meteor/react-meteor-data'
import {meteorApply} from 'meteor/janmp:schema-driven-ui'
import _ from 'lodash'

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

  <MarkDownEditor
    value={value}
    onChange={setValue}
    mayEdit={true}
  />