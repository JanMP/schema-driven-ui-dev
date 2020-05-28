import {Meteor} from 'meteor/meteor'
import {Mongo} from 'meteor/mongo'
import {ValidatedMethod} from 'meteor/mdg:validated-method'
import SimpleSchema from 'simpl-schema'
import {createAutoDataTableBackend} from 'meteor/janmp:schema-driven-ui'

SimpleSchema.extendOptions ['AutoTable', 'uniforms']

export Test = new Mongo.Collection 'test'

testSchema = new SimpleSchema
  _id:
    type: String
    optional: true
    uniforms: -> null
  name: String
  a: Number
  b: Number


listSchema = new SimpleSchema
  _id:
    type: String
    optional: true
    uniforms: -> null
  name: String
  sum: Number

pipeline = [
  $project:
    _id: 1
    name: 1
    sum: $add: ['$a', '$b']
]

export props = createAutoDataTableBackend
  viewTableRole: 'any'
  editRole: 'logged-in'
  sourceName: 'testList'
  sourceSchema: testSchema
  listSchema: listSchema
  formSchema: testSchema
  collection: Test
  usePubSub: true
  useAggregation: true
  pipelineMiddle: pipeline
  canEdit: true
  canAdd: true
  canDelete: true
  canSearch: true
 

