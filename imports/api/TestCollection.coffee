import {Meteor} from 'meteor/meteor'
import {Mongo} from 'meteor/mongo'
import {ValidatedMethod} from 'meteor/mdg:validated-method'
import SimpleSchema from 'simpl-schema'

import faker from 'faker'
import {loremIpsum} from 'lorem-ipsum'
import _ from 'lodash'

export TestCollection = new Mongo.Collection 'testCollection'

if Meteor.isServer
  if TestCollection.find().count() is 0
    [1..10000]
    .forEach (n) ->
      TestCollection.insert
        index: n
        name: loremIpsum count: _.random 1, 2 #faker.name.findName()
        description: loremIpsum count: _.random 1, 20
  
  Meteor.publish 'testCollection', ({skip, limit}) -> TestCollection.find {}, {skip, limit}