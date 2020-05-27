import React, {useState} from 'react'
import SimpleSchema from 'simpl-schema'
import AutoForm from 'uniforms-semantic/AutoForm'
import {Container} from 'semantic-ui-react'
import SimpleSchema2Bridge from 'uniforms-bridge-simple-schema-2'

schema = new SimpleSchema
  a: String
  b: Number

new SimpleSchema2Bridge schema

export default AutoFormTest = ->
  
  [model, setModel] = useState {}

  <Container>
    <h1>Hey!</h1>
    <pre>{JSON.stringify model, null, 2}</pre>
    <AutoForm
      schema={schema}
      model={model}
      onSubmit={setModel}
    />
  </Container>