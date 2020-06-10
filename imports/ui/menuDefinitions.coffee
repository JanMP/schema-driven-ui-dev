import AutoTableTest from './AutoTableTest'
import AutoFormTest from './AutoFormTest'
import QueryEditorTest from './QueryEditorTest'
import GridLayoutTest from './GridLayoutTest'

export default menuDefinitions = [
  label: 'AutoTableTest'
  path: '/auto-table-test'
  component: AutoTableTest
  icon:
    name: 'table'
,
  label: 'AutoFormTest'
  path: '/auto-form-test'
  component: AutoFormTest
,
  label: 'QueryEditorTest'
  path: '/query-editor-test'
  component: QueryEditorTest
,
  label: 'GridLayoutTest'
  path: '/grid-layout-test'
  component: GridLayoutTest
]
