import React from "react"
import {meteorApply} from 'meteor/janmp:schema-driven-ui'
import _ from 'lodash'

export default TestButton = ({row, columnKey, schema}) ->
  a = _.random 1, 100
  b = _.random 100, 1000

  onClick = ->
    meteorApply
      method: 'testList.setValue'
      data:
        _id: row?._id
        modifier: {a, b}

  <button onClick={onClick}>{a}, {b}</button>