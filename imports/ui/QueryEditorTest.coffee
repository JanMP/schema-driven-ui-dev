import React, {useState} from 'react'
import {Container, Segment} from 'semantic-ui-react'
import {QueryEditor} from 'meteor/janmp:schema-driven-ui'
import SimpleSchema from 'simpl-schema'


schema = new SimpleSchema
  a: String
  b: Number
  subDoc: Object
  'subDoc.x': Number
  'subDoc.y': Number

export default QueryEditorTest = ->

  [queryUiObject, setQueryUiObject] = useState null


  <Container>
    <Segment>
      <QueryEditor
        rule={queryUiObject}
        schema={schema}
        showRule={true}
        onChange={setQueryUiObject}
      />
    </Segment>
  </Container>