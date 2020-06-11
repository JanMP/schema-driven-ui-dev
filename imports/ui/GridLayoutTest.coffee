import React, {useState} from 'react'
import GridLayout, {WidthProvider} from 'react-grid-layout'
import {Segment} from 'semantic-ui-react'
import 'react-grid-layout/css/styles.css'
import 'react-resizable/css/styles.css'
import './react-grid.custom.styl'
import AutoFormTest from './AutoFormTest'
import AutoTableTest from './AutoTableTest'
import QueryEditorTest from './QueryEditorTest'

WindowContainer = ({children, title, key}) ->
  <div key="a">
      <div className="window">
        <div className="window-header">AutoFormTest</div>
        <div className="window-content">
          {children}
        </div>
      </div>
    </div>

  
Grid = WidthProvider GridLayout

export default GridLayoutTest = ({children})->

  defaultLayout = [
    {i: 'a', x: 0, y:0, w: 2, h: 1}
    {i: 'b', x: 0, y: 2, w: 2, h: 1}
    {i: 'c', x: 0, y: 4, w: 2, h: 1}
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

    <div key="c">
      <div className="window">
        <div className="window-header">AutoTableTest</div>
        <div className="window-content">
          <QueryEditorTest/>
        </div>
      </div>
    </div>
    
  </Grid>