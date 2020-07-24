import React, {useState, useEffect, useRef} from "react"
import {Button, Grid, Dimmer, Icon, Input, Loader, Modal} from 'semantic-ui-react'
import {useTracker} from 'meteor/react-meteor-data'
import {TestCollection} from '/imports/api/TestCollection'
import NewDataTable from "./NewDataTable.coffee"
import _ from 'lodash'

pageSize = 1000

export default NewTableTest = ->

  [sort, setSort] = useState index: 1
  [skip, setSkip] = useState 0
  [limit, setLimit] = useState pageSize

  resolveRef = useRef ->
  rejectRef = useRef ->

  isLoading = useTracker ->
    handle = Meteor.subscribe 'testCollection', {skip, limit}
    not handle.ready()
  , [skip, limit]

  rows = useTracker -> TestCollection.find({},{sort, skip, limit}).fetch()
  
  useEffect ->
    resolveRef.current() unless isLoading
  , [isLoading]

  loadMoreRows = ({startIndex, stopIndex}) ->
    if stopIndex >= limit
      setLimit limit+pageSize
    new Promise (res, rej) ->
      resolveRef.current = res
      rejectRef.current = rej

  <div style={backgroundColor: 'white', height: '100%'}>
    <NewDataTable
      rows={rows} totalRowCount={rows?.length+1} loadMoreRows={loadMoreRows}
      canSearch={true} onChangeSearch={(d) -> console.log 'onChangeSearch', d}
      mayEdit={true}
      canAdd={true} mayAdd={true} onAdd={-> console.log 'add'}
    />
  </div>
