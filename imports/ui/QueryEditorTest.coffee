import React, {useState, useEffect} from 'react'
import {Container, Segment} from 'semantic-ui-react'
import {QueryEditor, queryUiObjectToQuery} from 'meteor/janmp:schema-driven-ui'
import SimpleSchema from 'simpl-schema'

ListComponent = ->
  <span>ListComponent from Schema</span>

schema = new SimpleSchema
  a: String
  b:
    type: Number
    QueryEditor:
      inListField:
        type: String
        allowedValues: ['Liste 1', 'Liste 2']
  c:
    type: String
    QueryEditor:
      inListField:
        type: String
        allowedValues: ['A', 'B', 'C']
  subDoc: Object
  'subDoc.x': Number
  'subDoc.y': Number

listen =
  b:
    'Liste 1': [1,2,3]
    'Liste 2': [4,5,6]
  c:
    A: ['Auto', 'Ameise', 'Amerika']
    B: ['Baumeister', 'Bob', 'Banana']
    C: ['Chaos', 'Cannabis', 'Chilli']

getList = ({subject,predicate,object}) ->
  console.log {subject,predicate,object}
  listen[subject]?[object.value] ? []


export default QueryEditorTest = ->

  [queryUiObject, setQueryUiObject] = useState null
  [query, setQuery] = useState 1

  useEffect ->
    if queryUiObject?
      setQuery queryUiObjectToQuery {queryUiObject, getList}
      # console.log queryUiObject
  , [queryUiObject]


  <>
    <QueryEditor
      rule={queryUiObject}
      schema={schema}
      showRule={true}
      onChange={setQueryUiObject}
    />
    <Segment>
      <pre>{JSON.stringify queryUiObject, null, 2}</pre>
    </Segment>
    <Segment>
      <pre>{JSON.stringify query, null, 2}</pre>
    </Segment>
  </>