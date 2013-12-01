app.service 'charts', () ->
  this.configureMinicharts = (seriesSet, eventRows) ->
    eventTypes = Object.keys(seriesSet)
    seriesLoaded = 0
    seriesToLoad = eventTypes.length*2
    logLoad = (e) ->
      seriesLoaded++
      if(seriesLoaded == seriesToLoad)
        $(window).delay(100).trigger('resize')


    #assumes every event type has two series

    for eventType in eventTypes
      seriesArray = seriesSet[eventType]

      min = 0
      max = 0

      data1 = seriesArray[0].data
      data2 = seriesArray[1].data
      if data2.length == 0 and data2.lenth > 0
        min = data1[0].x
        max = data1[data1.length-1].x
      else if data1.length == 0 and data2.length > 0
        min = data2[0].x
        max = data2[data2.length-1].x
      else if data1.length > 0 and data2.length > 0
        min = Math.min(data2[0].x,data1[0].x)
        max = Math.max(data2[data2.length-1].x,data1[data1.length-1].x)
      halfRange = Math.max(-min,max)

      seriesArray[0]['visible'] = false

      config = {
        #series-specific options
        options: {
          chart: {
            type: 'areaspline',
            margin: [0, 0, 0, 0],
            spacingTop: 0,
            spacingBottom: 0,
            spacingLeft: 0,
            spacingRight: 0,
            height:100,
            events:{
              load: logLoad
            },
            zoomType:"x"
          },
          plotOptions: {
            series: {
                stacking: ''
            }
          },
          xAxis: {
            plotLines: [{
              value:0,
              color: 'red',
              width: 3,
              zIndex: 3
            }],
            labels:{
              enabled: false
            },
            min : -halfRange,
            max : halfRange,
            minRange : 60000
          },
          yAxis: {
            title: {
              text: ''
            },
            labels:{
              enabled: false
            }
          }
          legend:{
            enabled:false
          }
        },
        series: seriesArray,
        title: {
          text: ''
        },
        credits: {
          enabled: false
        },
        loading: false
      }

      obj = { chartConfig: config, eventName: eventType, coOccurence: seriesArray.coOccurence, peakOccurence: seriesArray.peakOccurence,
      standardDev: seriesArray.standardDev, frequency: seriesArray.frequency, roundedIntrScore: 0.0, roundedDistScore: 0.0 }

      eventRows.push( obj )

  this.configureMainChart = (eventData,chart) ->
    formatRelativeTime = (mills) ->
      if mills < 0 then sign = S('-') else sign = S('')
      absMs = Math.abs(mills)

      msInSeconds = 1000
      msInMinutes = msInSeconds * 60
      msInHours = msInMinutes * 60
      msInDays = msInHours * 24

      days = Math.round(absMs / msInDays)
      remainder = absMs % msInDays
      hours = Math.round(remainder / msInHours)
      remainder %= msInHours
      minutes = Math.round(remainder / msInMinutes)
      remainder %= msInMinutes
      seconds = Math.round(remainder / msInSeconds)
      milliseconds = remainder % msInSeconds

      relTimeStr = sign
      if days > 1 then relTimeStr += "#{days} days " else if days == 1 then relTimeStr += "1 day "
      relTimeStr += S("#{hours}:").padLeft(3,'0')
      relTimeStr += S("#{minutes}:").padLeft(3,'0')
      relTimeStr += S("#{seconds}.").padLeft(3,'0')
      relTimeStr += S(milliseconds).padLeft(3,'0')
      relTimeStr

    chart.config = {
      options:{
        chart:{
          type: 'areaspline'
        },
        tooltip:{
          formatter:()->
            tip = formatRelativeTime(this.x)
            if(this.points[0])
              tip +="<br/>#{this.points[0].series.name}:#{this.points[0].y}"
            if(this.points[1])
              tip +="<br/>#{this.points[1].series.name}:#{this.points[1].y}"
            return tip

        },
        xAxis: {
          plotLines: [{
            value:0,
            color: 'red',
            width: 3,
            zIndex: 3
          }],
          labels:{
            formatter:()->formatRelativeTime(this.value)
          },
          range: undefined
        },
      },
      title:{
        text:eventData.name
      },
      rangeSelector : {
        selected : 1
      },
      navigator:{
        enabled:true
      },
      credits: {
        enabled: false
      },


      series:eventData.series,
      useHighStocks:true
    }


