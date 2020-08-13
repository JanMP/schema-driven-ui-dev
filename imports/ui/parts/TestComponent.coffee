import React from "react"
import {connectWithFormField} from 'meteor/janmp:schema-driven-ui'

export default TestComponent =  ({row, columnKey, schema}) ->

  value = row?[columnKey] ? '[no value]'
  
  size = 10 * Math.log value

  style =
    fontSize: size
    color: if value > 100 then 'red' else 'black'

  <div style={padding: "#{size/2}px 0"}>
    <span style={style}>{value}</span>
  </div>