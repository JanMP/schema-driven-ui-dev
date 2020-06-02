import React, {useState, useEffect} from 'react'
import {Container, Segment} from 'semantic-ui-react'
import {QueryEditor, queryUiObjectToQuery} from 'meteor/janmp:schema-driven-ui'
import SimpleSchema from 'simpl-schema'


schema = new SimpleSchema
  a: String
  b: Number
  subDoc: Object
  'subDoc.x': Number
  'subDoc.y': Number

export default QueryEditorTest = ->

  [queryUiObject, setQueryUiObject] = useState null
  [query, setQuery] = useState 1

  useEffect ->
    if queryUiObject?
      setQuery queryUiObjectToQuery {queryUiObject}
  , [queryUiObject]


  <Container>
    <Segment>
      <QueryEditor
        rule={queryUiObject}
        schema={schema}
        showRule={true}
        onChange={setQueryUiObject}
      />
    </Segment>
    <Segment>
      <pre>{JSON.stringify queryUiObject, null, 2}</pre>
    </Segment>
    <Segment>
      <pre>{JSON.stringify query, null, 2}</pre>
    </Segment>
  </Container>