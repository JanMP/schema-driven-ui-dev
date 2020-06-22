import React, {useState} from "react"
import {MarkDownEditor} from 'meteor/janmp:schema-driven-ui'

export default MarkDownEditorTest = ->

  [value, setValue] = useState [1..10].map((n) -> "#{n}\n\n").join()

  <MarkDownEditor
    value={value}
    onChange={setValue}
    mayEdit={true}
  />