import React, {useState, useEffect, useRef} from "react"
import {useTracker} from 'meteor/react-meteor-data'
import {TestCollection} from '/imports/api/TestCollection'
import NewDataTable from "./NewDataTable.coffee"
import _ from 'lodash'

resolve = ->
reject = ->

pageSize = 100

export default NewTableTest = ->

  [skip, setSkip] = useState 0
  [limit, setLimit] = useState pageSize

  isLoading = useTracker ->
    handle = Meteor.subscribe 'testCollection', {skip, limit}
    not handle.ready()
  , [skip, limit]

  rows = useTracker -> TestCollection.find({},{skip, limit, sort: index: 1}).fetch()

  useEffect ->
    observer =
      TestCollection
      .find {},{skip, limit, sort: index: 1}
      .observe
        # addedAt: (args...) -> console.log 'addedAt', args...
        changedAt: (args...) -> console.log 'changedAt', args...
    -> observer.stop()
  , [skip, limit]

  useEffect ->
    resolve() unless isLoading
  , [isLoading]

  loadMoreRows = ({startIndex, stopIndex}) ->
    if stopIndex >= limit
      setLimit limit+pageSize
    new Promise (res, rej) ->
      resolve = ->
        res()
      reject = rej

  <NewDataTable rows={rows} totalRowCount={rows?.length+1} loadMoreRows={loadMoreRows}/>
