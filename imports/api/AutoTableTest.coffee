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

# fill our test collection with data
# note that we don't provide a value for the A+B column
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

# this is a publication I setup to check out how to manipulate
# the table data with an external python (example.py) script that logs in as a client
# you will have to create a user account for that script to be able to log in
if Meteor.isServer
  Meteor.publish 'pythonPublication', ->
    unless Meteor.user()?.username is 'pythonSum'
      console.error 'user isnt pythonSum???'
      @ready()
    else
      Test.find {pythonSum: $exists: false},
        sort: b: 1
        limit: 1

# this method is solely created for that python script
new ValidatedMethod
  name: 'setPythonSum'
  validate:
    new SimpleSchema
      id: String
      pythonSum: Number
    .validator()
  run: ({id, pythonSum}) ->
    console.log 'setPythonSum Methood', {id, pythonSum}
    Test.update {_id: id}, $set: {pythonSum}, (err, res) -> console.log 'ressult: ',  err, res

# this is where the actual code for the data table starts
# we define several simple-scemas and bits of mongodb aggregation pipelines

#this schema is used as our master schema (sourceSchema) and we use it also to build a form that allows to edit the table entry in a modal
# we don't have any custom components in that form, but we can easily set that up with the uniforms field
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
  pythonSum:
    type: Number
    optional: true

# this schema is used to build the table component itself
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
  pythonSum:
    type: Number
  bool:
    type: Boolean
    # AutoTable:
    #   editable: true

# this bit is used at the start of the aggregation pipeline
getPreSelectPipeline = -> [
    $match:
      a: $lt: 9
      b: $lt: 100
  ]

# this is the bit where we can manipulate the tabledata
# in this example we pass through the data of most fields
# and here we have mongo calculate the sum of a and b for us
# this happens befor searching and sorting (but after the preSelectPipeline bit)
# so we can search for the sums and sort by them

getProcessorPipeline = -> [
  $project:
    _id: 1
    name: 1
    a: 1
    b: 1
    alignment: 1
    bool: 1
    pythonSum: 1
    sum: $add: ['$a', '$b']
]

# here we call the function that takes all the stuff we defined above and some additional parameters
# and builds all our methods and publication
# the props we export are fed into the react compoment that displays the table
export props = createAutoDataTableBackend
  viewTableRole: 'any' # these are roles we can set for we have 'any' and 'logged-in' predefined, create your own with allanning:roles
  editRole: 'logged-in'
  sourceName: 'testList' # this get's to be a part of all the method and publication names that get set up
  sourceSchema: testSchema
  listSchema: listSchema # if we didn't set these they'd just default to sourceSchema
  formSchema: testSchema
  collection: Test
  # atm we only really support usePubSub and useAggregation, there's code for fetching data with methods and
  # without aggregation pipelines but that has not been used and tested in a while and is probably broken
  usePubSub: true
  useAggregation: true
  # getPreSelectPipeline: getPreSelectPipeline
  getProcessorPipeline: getProcessorPipeline
  canEdit: true # here we can turn on an off some functionality
  canAdd: true
  canDelete: true
  canSearch: true
 

