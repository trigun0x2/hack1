require 'httparty'
require 'pry'

def giant_terrible_method(ingredient)

	baseURI = 'http://api.yummly.com'
	appId = '548c220e'
	apiKey = "b542c6f2342b145ce8f524981bc75653"
	# set how many results we want
	maxResults = '100'
	query = ingredient
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
		unless recipe_response['nutritionEstimates'][0].nil?
			energy_attr = recipe_response['nutritionEstimates'].select{|nut| nut['attribute'] == 'ENERC_KCAL'}[0]
			if energy_attr == nil
				calories = 0
			else
				calories = energy_attr['value']
			end
			p '---------------------'
			p recipe_response['name']
			p

			recipes << {
									recipe_id: recipe_response['id'], 
									name: recipe_response['name'], 
									calories: calories,
									image_url: recipe_response['images'][0]['imageUrlsBySize']['90']
								 }
		end
	end

	# Write the data to the json file

	json = File.read('food_data.json')
	secondJsonArray = JSON.parse(json)

	concat_json = secondJsonArray + recipes

	File.open("food_data.json","w") do |f|
	  f.puts JSON.pretty_generate(concat_json)
	end
end

query_array = ['hamburger', 'cream','pork','fish','egg']
query_array.each {|q| giant_terrible_method(q)}


