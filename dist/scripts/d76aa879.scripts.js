(function(){window.app=angular.module("multifinderApp",["ngResource"]).config(["$routeProvider",function(a){return a.when("/",{templateUrl:"views/main.html",controller:"MainCtrl"}).otherwise({redirectTo:"/"})}])}).call(this),function(){app.controller("MainCtrl",["$scope",function(a){return a.categories=[{name:"Opponent Offense"},{name:"CHICAGO Offense"},{name:"Defensive Rebound"},{name:"Offensive Rebound"},{name:"Made Shot - 2"},{name:"Made Shot - 3"},{name:"Missed Shot - 2"},{name:"Missed Shot - 3"},{name:"Steal"},{name:"Timeout"},{name:"Turnover"},{name:"Foul"},{name:"Block"},{name:"Made Free Throw"},{name:"Missed Free Throw"},{name:"End of Period"},{name:"Jump Ball"},{name:"Dead Ball"}]}])}.call(this);