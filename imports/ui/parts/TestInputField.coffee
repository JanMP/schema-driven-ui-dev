import React from 'react'
import {connectWithFormField} from 'meteor/janmp:schema-driven-ui'

export default TestInputField = connectWithFormField ({value, onChange}) ->
  handleChange = (e) -> onChange e.target.value

  <input style={color: 'red'} onChange={handleChange} value={value}/>