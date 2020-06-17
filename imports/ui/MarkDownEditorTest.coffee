import React, {useState} from "react"
import {MarkDownEditor} from 'meteor/janmp:schema-driven-ui'

export default MarkDownEditorTest = ->

  [value, setValue] = useState "alles futsch"

  onChange = (v) ->
    console.log "MarkDownEditorTest.setValue", v
    setValue v

  <MarkDownEditor
    value={value}
    onChange={onChange}
  />