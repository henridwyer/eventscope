(function(){window.app=angular.module("multifinderApp",["ngResource"]).config(["$routeProvider",function(a){return a.when("/",{templateUrl:"views/main.html",controller:"MainCtrl"}).otherwise({redirectTo:"/"})}])}).call(this),function(){app.controller("MainCtrl",["$scope","$http",function(a,b){var c,d,e,f,g,h;return a.datasets=[{name:"example"},{name:"Basketball"},{name:"Medical"}],a.categories=[],a.selectedDataset=a.datasets[0],a.data=[],a.splitAttribute=!1,a.groups=[[],[]],c=function(b){return a.data=b},d=function(a){return b.get("datasets/"+a+".json").success(c)},a.$watch("selectedDataset",function(a){return d(a.name),a}),h=function(b){var c,d,e,f,g;for(a.categories=[],f=b.events,g=[],d=0,e=f.length;e>d;d++)c=f[d],-1===a.categories.indexOf(c.event)?g.push(a.categories.push(c.event)):g.push(void 0);return g},a.$watch("data",function(a){return h(a)}),a.$watch("splitAttribute",function(){return console.log("split update")}),e=function(){return 1},g=function(){return 1},f=function(b){var c,d,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x;for(console.log("re-creating histograms"),h=[],s=a.categories,i=0,m=s.length;m>i;i++)for(f=s[i],h[f]=[],t=a.categories,j=0,n=t.length;n>j;j++)g=t[j],h[f][g]={},h[f][g].td=[];for(u=b.events,k=0,o=u.length;o>k;k++)for(c=u[k],v=b.events,l=0,p=v.length;p>l;l++)d=v[l],h[c.event][d.event].td.push(d.ts-c.ts);for(w=b.events,x=[],r=0,q=w.length;q>r;r++)c=w[r],x.push(function(){var a,f,g,i;for(g=b.events,i=[],f=0,a=g.length;a>f;f++)d=g[f],i.push(h[c.event][d.event].is=e(h[c.event][d.event].td));return i}());return x},a.$watch("data",function(a){return f(a)})}])}.call(this);