require 'httparty'
require 'pry'

baseURI = 'http://api.yummly.com'
appId = '548c220e'
apiKey = "b542c6f2342b145ce8f524981bc75653"
# let's add a bunch of query strings that we then randomly sample
query_array = ['hamburger']
query = query_array.sample
# set how many results we want
maxResults = '5'

search_request_url = "#{baseURI}/v1/api/recipes?_app_id=#{appId}&_app_key=#{apiKey}&q=#{query}&maxResult=#{maxResults}"
# make the request
response = HTTParty.get(search_request_url)
# here's all the json data!
recipe_matches_json = JSON.parse(response.body)['matches']
# only keep the recipes with an image
recipe_matches_json.select!{|recipe| recipe['imageUrlsBySize'].any?}


# make get request for the recipe
recipes = []
recipe_matches_json.each do |recipe|
	recipe_id = recipe['id']
	recipe_request_url = "#{baseURI}/v1/api/recipe/#{recipe_id}?_app_id=#{appId}&_app_key=#{apiKey}&q=#{recipe_id}"
	recipe_response = HTTParty.get(recipe_request_url).parsed_response
	# save only the attributes we want
	recipes << {
							recipe_id: recipe_response['id'], 
							name: recipe_response['name'], 
							calories: recipe_response['nutritionEstimates'][0]['value'],
							image_url: recipe_response['images'][0]['imageUrlsBySize']['90']
						 }
end

# Write the data to the json file
json = File.read('test_data.json')
secondJsonArray = JSON.parse(json)

concat_json = secondJsonArray + recipes

File.open("test_data.json","w") do |f|
  f.puts JSON.pretty_generate(concat_json)
end

