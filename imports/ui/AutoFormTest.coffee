import React, {useState} from 'react'
import SimpleSchema from 'simpl-schema'
import AutoForm from 'uniforms-semantic/AutoForm'
import {Container, Segment} from 'semantic-ui-react'
import SimpleSchema2Bridge from 'uniforms-bridge-simple-schema-2'

schema = new SimpleSchema
  Name: String
  Alter: Number
  Hobbies: [String]

schemaBridge = new SimpleSchema2Bridge schema

export default AutoFormTest = ->
  
  [model, setModel] = useState {}

  <>
    <AutoForm
      schema={schemaBridge}
      model={model}
      onSubmit={setModel}
    />

    <h3>model:</h3>
    <Segment>
      <pre>{JSON.stringify model, null, 2}</pre>
    </Segment>
  </>