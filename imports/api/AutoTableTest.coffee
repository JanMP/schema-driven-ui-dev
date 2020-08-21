import {Meteor} from 'meteor/meteor'
import {Mongo} from 'meteor/mongo'
import {ValidatedMethod} from 'meteor/mdg:validated-method'
import SimpleSchema from 'simpl-schema'
import {createAutoDataTableBackend} from 'meteor/janmp:schema-driven-ui'
import TestComponent from '/imports/ui/parts/TestComponent'
import TestInput from '/imports/ui/parts/TestInput'
import TestInputField from '/imports/ui/parts/TestInputField'
import TestSelect from '/imports/ui/parts/TestSelect'
import _ from 'lodash'

SimpleSchema.extendOptions ['AutoTable', 'uniforms']

export Test = new Mongo.Collection 'test'

if Meteor.isServer
  if Test.find().count() is 0
    [1..10000]
    .forEach (n) ->
      Test.insert
        a: _.random 1, 100
        b: _.random 1, 1000
        name: "Test #{n}"
        alignment: _.sample ['chaotic', 'neutral', 'lawful']
        bool: _.sample [true, false]


testSchema = new SimpleSchema
  _id:
    type: String
    optional: true
    uniforms: -> null
  name: String
  a: Number
  b: Number
  alignment:
    type: String
    allowedValues: ['chaotic', 'neutral', 'lawful']
  bool:
    type: Boolean
    optional: true

listSchema = new SimpleSchema
  _id:
    type: String
    optional: true
    uniforms: -> null
  name: String
  a:
    type: Number
    min: 5
    # AutoTable:
    #   editable: true
  b:
    type: Number
    # AutoTable:
    #   editable: true
  sum:
    type: Number
    label: 'a + b'
    AutoTable:
      component: TestComponent
  alignment:
    type: String
    allowedValues: ['chaotic', 'neutral', 'lawful']
    AutoTable:
      editable: true
      overflow: true
  bool:
    type: Boolean
    # AutoTable:
    #   editable: true

getPreSelectPipeline = -> [
    $match:
      a: $lt: 9
      b: $lt: 100
  ]

getProcessorPipeline = -> [
  $project:
    _id: 1
    name: 1
    a: 1
    b: 1
    alignment: 1
    bool: 1
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
  # getPreSelectPipeline: getPreSelectPipeline
  getProcessorPipeline: getProcessorPipeline
  canEdit: true
  canAdd: true
  canDelete: true
  canSearch: true
 

