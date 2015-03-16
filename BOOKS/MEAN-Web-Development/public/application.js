var mainApplicationModuleName = 'mean';
var mainApplicationModule = angular.module(mainApplicationModuleName, ['ngRoute','example']);

//use Hashbangs configuration http://localhost:3000/#!/example for seo purpose
mainApplicationModule.config(['$locationProvider',
  function($locationProvider){
    $locationProvider.hashPrefix('!');
  }
]);

angular.element(document).ready(function(){
  angular.bootstrap(document, [mainApplicationModuleName]);
});
