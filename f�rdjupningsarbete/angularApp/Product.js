function ProductCtrl($scope, $http){
	$scope.productData;
	$scope.defaultError = "Ingen information";
	$http({method: 'GET', url: 'extract.php'}).success(function(data) {
		  	$scope.productData = data.data;
	});
	var Print = function(value){
		if(value != null)
		{
			return value;
		}
		else
		{
			return $scope.defaultError;
		}
	}
}