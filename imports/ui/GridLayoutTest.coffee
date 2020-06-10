import React, {useState} from 'react'
import GridLayout, {WidthProvider} from 'react-grid-layout'
import {Segment} from 'semantic-ui-react'
import 'react-grid-layout/css/styles.css'
import 'react-resizable/css/styles.css'
import AutoFormTest from './AutoFormTest'
import AutoTableTest from './AutoTableTest'

WindowContent = ({text}) ->
  <Segment style={height: '100%'}>
    <h1>{text}</h1>
  </Segment>
  
Grid = WidthProvider GridLayout

export default GridLayoutTest = ->

  defaultLayout = [
    {i: 'a', x: 1, y: 2, w: 2, h: 2}
    {i: 'b', x: 5, y: 2, w: 3, h: 3}
  ]

  [layout, setLayout] = useState defaultLayout

  <Grid
    style={poistion: 'relative'}
    className="layout"
    layout={layout}
    onLayoutChange={console.log}
    draggableHandle=".window-header"
    cols={12} rowHeight={30} width={1200}
  >
    <div key="a">
      <div className="window">
        <div className="window-header">AutoFormTest</div>
        <div className="window-content">
          <AutoFormTest/>
        </div>
      </div>
    </div>
    
    <div key="b">
      <div className="window">
        <div className="window-header">AutoTableTest</div>
        <div className="window-content">
          <AutoTableTest/>
        </div>
      </div>
    </div>
    
  </Grid>