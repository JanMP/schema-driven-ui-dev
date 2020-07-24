import React, {useEffect, useRef} from "react"
import {Button, Grid, Dimmer, Icon, Input, Loader, Modal} from 'semantic-ui-react'
import {
  Column, defaultTableRowRenderer, Table, CellMeasurer, CellMeasurerCache,
  InfiniteLoader
} from 'react-virtualized'
import useSize from '@react-hook/size'
import _ from 'lodash'


newCache = -> new CellMeasurerCache
  fixedWidth: true
  minHeight: 30
  defaultHeight: 200

cellRenderer = ({cache}) ->
  ({dataKey, parent, rowIndex, columnIndex, cellData, rowData}) ->
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

export default NewDataTable = ({
  rows, limit, totalRowCount, loadMoreRows
  canSearch, search, onChangeSearch = ->
  canAdd, onAdd = ->
  canDelete, onDelete = ->
  canEdit
  mayEdit
  canExport, onExportTable = ->
  mayExport
}) ->

  cacheRef = useRef newCache()

  headerContainerRef = useRef null
  [headerContainerWidth, headerContainerHeight] = useSize headerContainerRef

  contentContainerRef = useRef null
  [contentContainerWidth, contentContainerHeight] = useSize contentContainerRef

  tableRef = useRef null
  oldRows = useRef null

  forceUpdate = ->
    cacheRef.current.clearAll()
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

  <div ref={contentContainerRef} style={height: '100%'}>
    
    <div ref={headerContainerRef} style={margin: '10px'}>
      <Grid>
        <Grid.Row columns={3}>
          <Grid.Column>
            {totalRowCount}
          </Grid.Column>
          <Grid.Column>
            <div style={textAlign: 'center'}>
              {
                if canSearch
                  <Input
                    value={search}
                    onChange={(e, d) -> onChangeSearch d.value}
                    icon='search'
                  />
              }
            </div>
          </Grid.Column>
          <Grid.Column>
            <div style={textAlign: 'right'}>
              {
                if canExport
                  <Button icon='download' onClick={onExportTable} disabled={not mayExport}/>
              }
              {
                if canAdd
                  <Button size="small" secondary circular icon="plus" onClick={onAdd} disabled={not mayEdit}/>
              }
            </div>
          </Grid.Column>
        </Grid.Row>
      </Grid>
    </div>
   
      <InfiniteLoader
        isRowLoaded={isRowLoaded}
        loadMoreRows={loadMoreRows}
        rowCount={totalRowCount}
      >
        {({onRowsRendered, registerChild}) ->
          registerChild tableRef
          <Table
            width={contentContainerWidth}
            height={contentContainerHeight - headerContainerHeight - 10}
            headerHeight={30}
            rowHeight={cacheRef.current.rowHeight}
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
              cellRenderer={cellRenderer cache: cacheRef.current}
            />
            <Column
              dataKey="name"
              label="name"
              width={150}
              flexGrow={1}
              cellRenderer={cellRenderer cache: cacheRef.current}
            />
            <Column
              dataKey="description"
              label="description"
              width={150}
              flexGrow={1}
              style={whiteSpace: 'normal'}
              cellRenderer={cellRenderer cache: cacheRef.current}
            />
          </Table>
        }
      </InfiniteLoader>
    
  </div>