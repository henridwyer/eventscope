app.controller 'MainCtrl', ['$scope', '$http', ($scope, $http) ->
  ### Dataset Variables ###
  $scope.datasets = [
  	{'name': 'example'},
    {'name': 'Basketball'},
    {'name': 'Medical'}
  ]
  refEvts = {}
  
  
  $scope.categories = []
  $scope.selectedDataset = $scope.datasets[0]
  $scope.data = []
  $scope.records = []
  $scope.splitAttribute = false
  $scope.groups = [ [], [] ] # group A is empty and group B is empty

  
  ### React to selectDataset selection changes ###
  $scope.$watch('selectedDataset', (newValue, oldValue, $scope) -> fetchJSON(newValue.name); return newValue; )
  
  ### Do/handle HTTP Get request ###
  cb = (data) -> $scope.data = data;
  fetchJSON = (fileName) -> $http.get('datasets/'+fileName+'.json').success( cb );  
  
  ### Edit scope.categories ###
  preprocess = (json) ->
    refEvts = {}
    $scope.categories = []
    if json.events
      for p in json.events
        $scope.categories.push(p.event) if p.event not in $scope.categories
        if p.ts
          p.ts = moment(p.ts)
          if p.te
            p.te = moment(p.te)
      $scope.categories.sort()
      #$scope.$apply()
      console.log("done with category updates")
      
	

  ### Update categories for each dataset ###
  $scope.$watch('data', (newValue, oldValue, $scope) -> preprocess(newValue) );
  
  
  
  ### TODO NEED SOME CONTROL TO SPLIT THE DATA ###
  $scope.$watch('splitAttribute', (newValue, oldValue, $scope) -> console.log('split update') );
  
  ### Does hist meet support thresh/similarity ###
  interestingScorePair = ( timeSeries ) -> return 1.0; 
  similarityScorePair  = ( timeSeriesA, timeSeriesB ) -> return 1.0; 

  ### Calculate some pair histograms ###

  ###
    reHistPair = (data) ->
        console.log('re-creating histograms')
        m = []
        for elem1 in $scope.categories
          m[elem1] = []
          for elem2 in $scope.categories
            m[elem1][elem2] = { }
            m[elem1][elem2]['td'] = []
        if data.events
          for a in data.events
            for b in data.events
              m[a.event][b.event]['td'].push(b.ts - a.ts)
          for a in data.events
            for b in data.events
              m[a.event][b.event]['is'] = interestingScorePair(m[a.event][b.event]['td'])###

  ### Not sure what to do with this now, put it in some histograms? ### 

  #$scope.$watch('data', (newValue, oldValue, $scope) -> reHistPair(newValue))
  
  
    
  $http.get("datasets/basicAreaChart.json").success (data) ->
    $scope.basicAreaChart = data	

  $scope.setRefEvt = (category) ->
    if refEvts[category]
      #remove event from selection
      delete refEvts[category]
      console.log "deselected #{category}"
    else 
      if Object.keys(refEvts).length >= 2
        console.log "replaced #{Object.keys(refEvts)[1]} with #{category}"
        #adding would cause overflow - replace one of the selected events
        delete refEvts[Object.keys(refEvts)[1]]
      else
        console.log "selected #{category}"
      #add event to selection
      refEvts[category] = true
]



