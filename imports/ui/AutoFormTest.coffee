import React, {useState} from 'react'
import SimpleSchema from 'simpl-schema'
import {AutoForm, QueryEditorField} from 'meteor/janmp:schema-driven-ui'
import {Container, Segment} from 'semantic-ui-react'
import SimpleSchema2Bridge from 'uniforms-bridge-simple-schema-2'

querySchema = new SimpleSchema
  a: String
  b: Number
  c: Array
  'c.$': Object
  'c.$.x': Number
  'c.$.y': Number

schema = new SimpleSchema
  String: String
  Number:
    type: Number
    min: -2
    max: 3
  Integer: SimpleSchema.Integer
  Date: Date
  Bool: Boolean
  Select:
    type: String
    allowedValues: ['Option 1', 'Option 2', 'fnord']
  Array: Array
  'Array.$': Object
  'Array.$.String': String
  'Array.$.Number': Number
  Query:
    type: Object
    blackbox: true
    uniforms:
      component: QueryEditorField
      schema: querySchema
      path: ''


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