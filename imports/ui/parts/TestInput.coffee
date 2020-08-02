import React from "react"
import {Input} from 'semantic-ui-react'
import {meteorApply} from 'meteor/janmp:schema-driven-ui'
import _ from 'lodash'

export default TestInput = ({row, columnKey, schema}) ->


  onClick = (e) ->
    e.stopPropagation()
    e.nativeEvent.stopImmediatePropagation()
   
  onChange = (e) ->
    value = e?.target?.value
    meteorApply
      method: 'testList.setValue'
      data:
        _id: row?._id
        modifier: "#{columnKey}": _.toNumber value

  <Input onClick={onClick} onChange={onChange} value={row?[columnKey]}/>