import React, {useState} from 'react'
import 'react-grid-layout/css/styles.css'
import 'react-resizable/css/styles.css'
import './react-grid.custom.styl'
import {WindowGrid, WindowContainer} from 'meteor/janmp:schema-driven-ui'
import AutoFormTest from './AutoFormTest'
import AutoTableTest from './AutoTableTest'
import QueryEditorTest from './QueryEditorTest'
import MarkDownEditorTest from './MarkDownEditorTest'

export default GridLayoutTest = ->
  <WindowGrid name="TestGrid">
    <WindowContainer title="AutoTableTest" noOverflow>
      <AutoTableTest/>
    </WindowContainer>
    <WindowContainer title="AutoFormTest">
      <AutoFormTest/>
    </WindowContainer>
    <WindowContainer title="QueryEditorTest">
      <QueryEditorTest/>
    </WindowContainer>
    <WindowContainer title="MarkDownEditorTest" noOverflow>
      <MarkDownEditorTest/>
    </WindowContainer>
  </WindowGrid>