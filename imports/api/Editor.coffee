import {Meteor} from 'meteor/meteor'
import {Mongo} from 'meteor/mongo'
import {ValidatedMethod} from 'meteor/mdg:validated-method'
import SimpleSchema from 'simpl-schema'

export Editor = new Mongo.Collection 'editor'

if Meteor.isServer
  Meteor.publish 'editor', -> Editor.find()

new ValidatedMethod
  name: 'editor.set'
  validate:
    new SimpleSchema
      value: String
    .validator()
  run: ({value}) -> Editor.upsert {_id: 'the-one'}, {value}