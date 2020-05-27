import React, {useState} from 'react'
import SimpleSchema from 'simpl-schema'
import AutoForm from 'uniforms-semantic/AutoForm'
import {Container} from 'semantic-ui-react'

schema = new SimpleSchema
  a: String
  b: Number

export default AutoFormTest = ->
  
  [model, setModel] = useState {}

  <Container>
    <h1>Hey!</h1>
    <pre>{JSON.stringify model, null, 2}</pre>
    <AutoForm
      schema={schema}
      model={model}
    />
  </Container>