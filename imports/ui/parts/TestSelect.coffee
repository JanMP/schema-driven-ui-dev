import React from "react"
import {meteorApply} from 'meteor/janmp:schema-driven-ui'
import {Select} from 'semantic-ui-react'
import _ from 'lodash'

options = ['chaotic', 'neutral', 'lawful'].map (x) -> key: x, value: x, text: x

export default TestSelect = ({row, columnKey, schema}) ->

  onClick = (e) ->
    e.stopPropagation()
    e.nativeEvent.stopImmediatePropagation()
   
  onChange = (e) ->
    value = e?.target?.value
    meteorApply
      method: 'testList.setValue'
      data:
        _id: row?._id
        modifier: a: _.toNumber value

  <Select onClick={onClick} onChange={onChange} value={row?.alignment} options={options}/>