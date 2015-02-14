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

request_url = "#{baseURI}/v1/api/recipes?_app_id=#{appId}&_app_key=#{apiKey}&q=#{query}&maxResult=#{maxResults}"

response = HTTParty.get(request_url)
# here's all the json data!
recipe_matches_json = JSON.parse(response.body)['matches']

# only keep the recipes with an image
recipe_matches_json.select!{|recipe| recipe['imageUrlsBySize'].any?}

# we just want the recipe id...
slimed_recipe_json = recipe_matches_json.map do |recipe| 
	Hash[*recipe.select {|k,v| ['id','imageUrlsBySize'].include?(k)}.flatten]
end

# Write the data to the json file
json = File.read('test_data.json')
secondJsonArray = JSON.parse(json)

concat_json = secondJsonArray + slimed_recipe_json

File.open("test_data.json","w") do |f|
  f.puts JSON.pretty_generate(concat_json)
end

