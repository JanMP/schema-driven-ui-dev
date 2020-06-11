import React, {useState} from 'react'
import 'react-grid-layout/css/styles.css'
import 'react-resizable/css/styles.css'
import './react-grid.custom.styl'
import {WindowGrid, WindowContainer} from 'meteor/janmp:schema-driven-ui'
import AutoFormTest from './AutoFormTest'
import AutoTableTest from './AutoTableTest'
import QueryEditorTest from './QueryEditorTest'

export default GridLayoutTest = ->
  <WindowGrid name="TestGrid">
    <WindowContainer title="AutoFormTest">
      <AutoFormTest/>
    </WindowContainer>
    <WindowContainer title="AutoTableTest">
      <AutoTableTest/>
    </WindowContainer>
    <WindowContainer title="QueryEditorTest">
      <QueryEditorTest/>
    </WindowContainer>
    <WindowContainer title="QueryEditorTest2">
      <QueryEditorTest/>
    </WindowContainer>
  </WindowGrid>