'use strict';

var teamdriveApp = angular.module('teamdriveApp', [
	'ngRoute',
  'ngDialog',
  'ui.utils.masks',
  'slick',
  'ngSanitize'
	]);

teamdriveApp.config(['$routeProvider', function($routeProvider) {
	$routeProvider
		.when ('/',{
			templateUrl: 'template/main.html',
      controller: 'mainCtrl'
		})
    .when ('/news',{
      templateUrl: 'template/news.html'
    })
    .when ('/news/:newsID',{
      templateUrl: 'template/newsDetail.html',
      controller: 'newsDetailCtrl'
    })
    .when ('/articles',{
      templateUrl: 'template/articles.html'
    })
    .when ('/articles/:articlesID',{
      templateUrl: 'template/articlesDetail.html',
      controller: 'articlesDetailCtrl'
    })
    .when ('/tests',{
      templateUrl: 'template/tests.html'
    })
    .when ('/tests/:testsID',{
      templateUrl: 'template/testsDetail.html',
      controller: 'testsDetailCtrl'
    })
    .when ('/events/:eventsID',{
      templateUrl: 'template/eventsDetail.html',
      controller: 'eventsDetailCtrl'
    })
    .when ('/terrapods/:terrapodsID',{
      templateUrl: 'template/terrapodsDetail.html',
      controller: 'terrapodsDetailCtrl'
    })
		.otherwise ({
			redirectTo:'/'
		});
		
}]);

teamdriveApp.controller("mainCtrl",['$scope','$rootScope', '$http', '$location','$anchorScroll','ngDialog',
  function($scope,$rootScope, $http, $location, $anchorScroll,ngDialog) {

  $http.get('http://teamdrive.herokuapp.com/api/v1/events').success(function(data, status, headers, config) {
      $scope.events = data;
  });

   $http.get('http://teamdrive.herokuapp.com/api/v1/news').success(function(data, status, headers, config) {
      $scope.news = data;
  });

  $http.get('http://teamdrive.herokuapp.com/api/v1/articles').success(function(data, status, headers, config) {
      $scope.articles = data;
  });

  $http.get('http://teamdrive.herokuapp.com/api/v1/grounds').success(function(data, status, headers, config) {
      $scope.grounds = data;
  });

  $scope.clickToOpen = function () {
    ngDialog.open({ template: 'eventModal' });
  };
  $scope.rememberID = function (a) {
    $rootScope.thisID = a;
    console.log('$rootScope.thisID',$rootScope.thisID);
  };
  
  $scope.loadVideo = function () {
    $('#my-video').backgroundVideo();
  };

  $scope.rememberTitle = function (a) {
    console.log(a);
    $rootScope.thisTitle = a;
  };
  $scope.limitPosts = function () {
    $rootScope.limit = 4;
  };
  $scope.predelPosts = function () {
    $rootScope.predel = 6;
  };

  $scope.showMap = function (wtf) {
    if (wtf) {
      $('.mapSection').css("z-index","99999");
      $('.mapSection').css("opacity","1");
    } else {
      $('.mapSection').css("z-index","-666");
      $('.mapSection').css("opacity","0");
    }
  };
  $scope.breakpoints = [
    {
      breakpoint: 768,
      settings: {
        slidesToShow: 1,
        slidesToScroll: 1,
        arrows:false,
        dots:true
      }
    }
  ];
}]);

teamdriveApp.controller("newsDetailCtrl",['$scope','$http', '$location', '$routeParams',
function($scope, $http, $location, $routeParams) {
    $scope.newsID = $routeParams.newsID;
    var url = 'http://teamdrive.herokuapp.com/api/v1/news/'+$routeParams.newsID;
    $http.get(url).success(function(data, status, headers, config) {
        $scope.someNews = data;
        console.log("someNews",$scope.someNews);
    });
}]); 


teamdriveApp.controller("articlesDetailCtrl",['$scope','$http', '$location', '$routeParams',
function($scope, $http, $location, $routeParams) {
    $scope.articlesID = $routeParams.articlesID;
    var url = 'http://teamdrive.herokuapp.com/api/v1/articles/'+$routeParams.articlesID;
    $http.get(url).success(function(data, status, headers, config) {
        $scope.article = data;
        console.log("article",$scope.article);
    });
}]);

teamdriveApp.controller("testsDetailCtrl",['$scope','$http', '$location', '$routeParams',
function($scope, $http, $location, $routeParams) {
    $scope.testsID = $routeParams.testsID;
    var url = 'http://teamdrive.herokuapp.com/api/v1/grounds/'+$routeParams.testsID;
    $http.get(url).success(function(data, status, headers, config) {
        $scope.ground = data;
    });
}]);
teamdriveApp.controller("eventsDetailCtrl",['$scope','$http', '$location', '$routeParams', '$sce',
function($scope, $http, $location, $routeParams, $sce) {
    $scope.eventsID = $routeParams.eventsID;
    var url = 'http://teamdrive.herokuapp.com/api/v1/events/'+$routeParams.eventsID;
    $http.get(url).success(function(data, status, headers, config) {
        $scope.event = data;
    });

}]);
teamdriveApp.controller("terrapodsDetailCtrl",['$scope','$http', '$location', '$routeParams',
function($scope, $http, $location, $routeParams) {
    $scope.terrapodsID = $routeParams.terrapodsID;
    var url = 'http://teamdrive.herokuapp.com/api/v1/terrapods/'+$routeParams.terrapodsID;
    $http.get(url).success(function(data, status, headers, config) {
        $scope.terrapod = data;
    });

}]);

teamdriveApp.controller("slickCtrl",['$scope','$rootScope', '$http', '$location',
  function($scope,$rootScope, $http, $location) {

  $http.get('http://teamdrive.herokuapp.com/api/v1/terrapods').success(function(data, status, headers, config) {
      $scope.terrapods = data;
      console.log($scope.terrapods);
     

  });
    
     $scope.tc = [0,0,0,0,0,0];
     $rootScope.sum = 0;
     $rootScope.skid = 0;
    
    $scope.addCount = function(id) {
      $scope.tc[id]++;
      $scope.sumF();
      console.log('$rootScope.sum', $rootScope.sum);

    };

    $scope.removeCount = function(id) {
      if ($scope.tc[id]>0) { $scope.tc[id]--; $scope.sumF();
      }
      
      console.log('$rootScope.sum', $rootScope.sum);
    }
    $scope.sumF = function() {
      var a1 = $scope.tc[0];
      var a2 = $scope.tc[1];
      var a3 = $scope.tc[2];
      var a4 = $scope.tc[3];
      var a5 = $scope.tc[4];
      var a6 = $scope.tc[5];
      var min_1 = 100;
      var min_2 = 100;
      var k = [1,1,1,1,1,1];
      var p = [70000,25000,25000,25000,90000,105000];
      var dual_min = false;
      var i;
      var num_max = -1;
      var no_null = 0;
      var max = 0;
      $rootScope.sum = 0;
      $rootScope.skid = 0;
      $scope.t = $scope.tc;
      console.log('t start', $scope.t);

      for (i = 0; i<=3; i++) {
        if ($scope.t[i] > 0) no_null++;
      }
      
      if (($scope.t[0]!=0)&&($scope.t[1]!=0)&&($scope.t[2]!=0)&&($scope.t[3]!=0)) {
        $rootScope.sum = 'Индивидуальный рассчет';
        $rootScope.skid = 0;
        return;
      }

      if (($scope.t[0]>15)||($scope.t[1]>15)||($scope.t[2]>15)||($scope.t[3]>15)) {
        $rootScope.sum = 'Индивидуальный рассчет';
        $rootScope.skid = 0;
        return;
      }

      if (($scope.t[0]!=0)&&($scope.t[1]+$scope.t[2]+$scope.t[3] != 0)) {
        for( i = 0; i<= 3; i++) {
          if ($scope.t[i]==min_1) dual_min = true;
          if (($scope.t[i]<min_1)&&($scope.t[i]!=0)) min_1 = $scope.t[i];
        }
        if(min_1 != 100) {
          for(i = 0; i<=3; i++) {
            if($scope.t[i]!=0) $scope.t[i] = $scope.t[i] - min_1;
          }
        } 
        
      }
      
      if (($scope.t[0]!=0)&&($scope.t[1]+$scope.t[2]+$scope.t[3] != 0)) {
        for(i = 0; i<= 3; i++) {
          if (($scope.t[i]<min_2)&&($scope.t[i]!=0)) min_2 = $scope.t[i];
        }
        if(min_2 != 100) {
          for(i = 0; i<=3; i++) {
            if($scope.t[i]!=0) $scope.t[i] = $scope.t[i] - min_2;
          }
        } 
      }
      

      if ((min_1 != 100)&&(min_2 != 100)) { $scope.t[4] = min_2; $scope.t[5] = min_1;}
      if ((min_1 != 100)&&(no_null>2)) { $scope.t[5] = min_1; }
      if ((min_1 != 100)&&(no_null<=2)) { $scope.t[4] = min_1; }
      // if ((min_1 != 100)&&(min_2 != 100)) { $scope.t[4] = min_2; $scope.t[5] = min_1;}
      // else  if ((min_1 != 100)&&(dual_min==false)) {$scope.t[4] = min_1;}
      //       else if ((min_1 != 100)&&(dual_min==true)) {$scope.t[5] = min_1;}

      for (i=0; i<=5; i++) {
        if ($scope.t[i] == 1) { k[i] = 1;}
        if (($scope.t[i] >= 2)&&($scope.t[i] < 5)) { k[i] = 0.9;}
        if (($scope.t[i] >= 5)&&($scope.t[i] < 10)) { k[i] = 0.8;}
        if ($scope.t[i] >= 10) { k[i] = 0.7;}
      } 
      for(i=0;i<=5;i++) {
        $rootScope.sum = $rootScope.sum + p[i]*$scope.t[i]*k[i];
      }
      
      $scope.tc[0] = a1; 
      $scope.tc[1] = a2;
      $scope.tc[2] = a3;
      $scope.tc[3] = a4;
      $scope.tc[4] = a5;
      $scope.tc[5] = a6;
      for (i = 0; i<=3; i++) {
        $rootScope.skid = $rootScope.skid + $scope.tc[i]*p[i];
      }
      
      // if (num_max!=-1) { $rootScope.skid = $scope.tc[num_max]*p[num_max] }
      // else  $rootScope.skid = 0;
      $rootScope.skid = $rootScope.skid - $rootScope.sum;
      $rootScope.sum = $rootScope.sum + ' руб.'
    }
    
    // $scope.removeCount = function(id) {
    //   for (var i = 0; i < $scope.terrapods.length; i++ ) {
    //     if ($scope.terrapods[i].id == id) {

    //       if ( $scope.terrapods[i].count > 0 )
    //       $scope.terrapods[i].count--;
    //       if ($scope.terrapods[i].count <2) {$scope.terrapods[i].price_user = $scope.terrapods[i].price*1; break;}
    //       if ($scope.terrapods[i].count <5) {$scope.terrapods[i].price_user = $scope.terrapods[i].price*0.9; break;}
    //       if ($scope.terrapods[i].count <10) {$scope.terrapods[i].price_user = $scope.terrapods[i].price*0.8; break;}
    //       }
    //     } 
    //   };
    $scope.getPrice = function(ter) {
      if (ter != undefined) {
        var rezult = 0;
        for (var i = 0; i< ter.length; i++ ) {
          if (ter[i].count != 0) {
            rezult=rezult+ter[i].price_user*ter[i].count;
          }

        }
        return Math.floor(rezult);
      }
    };
    $scope.getSale = function(ter) {
      if (ter != undefined) {
        var rezult = 0;

        for (var i = 0; i< ter.length; i++ ) {
          if (ter[i].count != 0) {
            rezult=rezult+(ter[i].price - ter[i].price_user)*ter[i].count;
          }        
        }
        return Math.floor(rezult);
      }
    };

    $scope.sendData  = function (ter) {
      if (ter != undefined) {
        var rezult="";
        for (var i = 0; i< ter.length; i++ ) {
          if (ter[i].count != 0) {
            rezult= rezult +ter[i].title + "цена:("+ter[i].price_user+"), кол-во:(" + ter[i].count + "); ||";
          }
        }
        return rezult;
      }
    };

  
  $scope.breakpoints = [
   {
      breakpoint: 1200,
      settings: {
        slidesToShow: 3,
        slidesToScroll:3
      }
    },
    {
      breakpoint: 768,
      settings: {
        slidesToShow: 2,
        slidesToScroll: 2,
        arrows:false,
        dots:true
      }
    }, {
      breakpoint: 480,
      settings: {
        slidesToShow: 1,
        slidesToScroll: 1,
        arrows:false,
        dots:true
      }
    }
  ];
}]);

teamdriveApp.run(function($rootScope, $location, $anchorScroll, $routeParams) {
  $rootScope.$on('$routeChangeSuccess', function(newRoute, oldRoute) {
    $location.hash($routeParams.scrollTo);
    $anchorScroll();  
  });
});

teamdriveApp.directive('myYoutube', function($sce) {
  return {
    restrict: 'EA',
    scope: { code:'=' },
    replace: true,
    template: '<iframe src="{{url}}" frameborder="0" allowfullscreen></iframe>',
    link: function (scope) {
        scope.$watch('code', function (newVal) {
           if (newVal) {
               scope.url = $sce.trustAsResourceUrl("http://www.youtube.com/embed/" + newVal);

           }
        });
    }
  };
});

// teamdriveApp.filter('reverse', function() {
//   return function(items) {
//     return items.slice().reverse();
//   };
// });
