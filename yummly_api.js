$(document).ready(function(){

	var baseURI = 'http://api.yummly.com'
	var appId = '548c220e'
	var apiKey = "b542c6f2342b145ce8f524981bc75653"

	// let's add a bunch of query strings that we then randomly sample
	var query_array = ['hamburger']

	var query = query_array[Math.floor(Math.random()*query_array.length)]

	// set how many results you want
	var maxResults = '5'

	var request_url = baseURI + "/v1/api/recipes?_app_id="+appId+"&_app_key="+apiKey+"&q="+query+"&maxResult="+maxResults
	$.ajax({
	  type: "GET",
	  dataType: "jsonp",
	  url: request_url
	}).success(function(data){
		console.log('we got it baby');
	});
});