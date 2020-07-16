import React, {useEffect, useRef} from "react"
import {Column, defaultTableRowRenderer, Table, CellMeasurer, CellMeasurerCache} from 'react-virtualized'
import useSize from '@react-hook/size'
import _ from 'lodash'



N = 10000
dataKeys = ['name', 'description']



cache = new CellMeasurerCache
  fixedWidth: true
  minHeight: 30
  defaultHeight: 300

cellRenderer = ({dataKey, parent, rowIndex, columnIndex, cellData, rowData}) ->
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

export default NewDataTable = ({rows}) ->

  contentContainerRef = useRef null
  [contentContainerWidth, contentContainerHeight] = useSize contentContainerRef

  getRow = ({index}) -> result = rows[index]
  
  useEffect ->
    cache.clearAll()
    return
  , [contentContainerWidth, contentContainerHeight]
  

  <div ref={contentContainerRef} style={height: '100%', width: '100%'}>
    <Table
      width={contentContainerWidth}
      height={contentContainerHeight}
      headerHeight={30}
      rowHeight={cache.rowHeight}
      rowCount={rows.length}
      rowGetter={getRow}
    >
      <Column
        dataKey="index"
        label="index"
        width="100"
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
  </div>