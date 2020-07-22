import React, {useState, useEffect, useRef} from "react"
import {useTracker} from 'meteor/react-meteor-data'
import {TestCollection} from '/imports/api/TestCollection'
import NewDataTable from "./NewDataTable.coffee"
import _ from 'lodash'

resolve = ->
reject = ->

export default NewTableTest = ->

  [skip, setSkip] = useState 0
  [limit, setLimit] = useState 10

  isLoading = useTracker ->
    handle = Meteor.subscribe 'testCollection', {skip, limit}
    not handle.ready()
  , [skip, limit]

  rows = useTracker -> TestCollection.find({},{skip, limit, sort: index: 1}).fetch()

  # useEffect ->
  #   console.log rows
  #   return
  # , [rows]

  useEffect ->
    console.log {isLoading}
    if isLoading is false then resolve()
  , [isLoading]

  loadMoreRows = ({startIndex, stopIndex}) ->
    if stopIndex >= limit
      setLimit limit+10
    new Promise (res, rej) ->
      resolve = ->
        res()
      reject = rej

  <NewDataTable rows={rows} totalRowCount={rows?.length+1} loadMoreRows={loadMoreRows}/>
