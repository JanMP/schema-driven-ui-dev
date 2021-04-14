import React, {useRef} from 'react'
import useSize from '@react-hook/size'
import { Calendar, momentLocalizer } from 'react-big-calendar'
import moment from 'moment'

localizer = momentLocalizer(moment)

events = [
  title: "NOW!"
  start: new Date()
  end: new Date(2021, 1, 21)
  allDay: true
  backgroundColor: "red"
]


export default BigCalendarTest = ->

  contentContainerRef = useRef null
  [contentContainerWidth, contentContainerHeight] = useSize contentContainerRef
 
  <div ref={contentContainerRef} style={height: '100%', width: '100%'}>
    <Calendar
      localizer={localizer}
      style={height: contentContainerHeight, width: contentContainerWidth}
      events={events}
    />
  </div>
 
 
