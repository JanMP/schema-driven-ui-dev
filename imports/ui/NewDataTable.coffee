import React, {useEffect, useRef} from "react"
import {
  Column, defaultTableRowRenderer, Table, CellMeasurer, CellMeasurerCache,
  InfiniteLoader
} from 'react-virtualized'
import useSize from '@react-hook/size'
import _ from 'lodash'


cache = new CellMeasurerCache
  fixedWidth: true
  minHeight: 30
  defaultHeight: 300

cellRenderer = ({dataKey, parent, rowIndex, columnIndex, cellData, rowData}) ->
  cache.clear {rowIndex, columnIndex}
  <CellMeasurer
    cache={cache}
    columnIndex={columnIndex}
    key={dataKey}
    parent={parent}
    rowIndex={rowIndex}
  >
   <div
    style={whiteSpace: 'normal', height: '100%'}
   >
    {cellData}
   </div>
  </CellMeasurer>

export default NewDataTable = ({rows, limit, totalRowCount, loadMoreRows}) ->

  contentContainerRef = useRef null
  [contentContainerWidth, contentContainerHeight] = useSize contentContainerRef

  tableRef = useRef null
  oldRows = useRef null

  forceUpdate = ->
    console.log 'forceUpdate'
    cache.clearAll()
    tableRef?.current?.forceUpdateGrid?()
    return

  useEffect forceUpdate, [contentContainerWidth, contentContainerHeight]

  useEffect ->
    length = rows?.length ? 0
    oldLength = oldRows?.current?.length ? 0
    if length > oldLength
      forceUpdate() unless _.isEqual rows?[0...oldLength], oldRows?.current
    else
      forceUpdate() unless _.isEqual rows, oldRows?.current
    oldRows.current = rows
    return
  , [rows]


  getRow = ({index}) -> rows[index] ? {}
  isRowLoaded = ({index}) -> rows?[index]?
  loadMoreRowsAndClearCache = ({startIndex, stopIndex}) ->
    await loadMoreRows({startIndex, stopIndex})

  <div ref={contentContainerRef} style={height: '100%', width: '100%'}>
    <InfiniteLoader
      isRowLoaded={isRowLoaded}
      loadMoreRows={loadMoreRowsAndClearCache}
      rowCount={totalRowCount}
    >
    {({onRowsRendered, registerChild}) ->
      registerChild tableRef
      <Table
        width={contentContainerWidth}
        height={contentContainerHeight}
        headerHeight={30}
        rowHeight={cache.rowHeight}
        rowCount={totalRowCount}
        rowGetter={getRow}
        onRowsRendered={onRowsRendered}
        ref={tableRef}
        overscanRowCount={1}
      >
        <Column
          dataKey="index"
          label="index"
          width={100}
          cellRenderer={cellRenderer}
        />
        <Column
          dataKey="name"
          label="name"
          width={150}
          flexGrow={1}
          cellRenderer={cellRenderer}
        />
        <Column
          dataKey="description"
          label="description"
          width={150}
          flexGrow={1}
          style={whiteSpace: 'normal'}
          cellRenderer={cellRenderer}
        />
      </Table>
    }
    </InfiniteLoader>
  </div>