import React from "react"
import NewDataTable from "./NewDataTable.coffee"

import faker from 'faker'
import {loremIpsum} from 'lorem-ipsum'

import _ from 'lodash'

N = 10000
rows = [1..N].map (n) ->
  index: n
  name: loremIpsum count: _.random 1, 20 #faker.name.findName()
  description: loremIpsum count: _.random 1, 30

export default NewTableTest = ->

  <NewDataTable rows={rows}/>
