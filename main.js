var RecipeGenerator = new function(){
  var db = data;

  this.random_recipe = function(){
    random_recipe = db[Math.floor(Math.random()*db.length)]
    this.set_recipe(random_recipe);
  };

  this.set_recipe = function(recipe){
    $("#guess-image").attr("src", recipe.smallImageUrls[0]);
    $("#guess-name").text(recipe.recipeName);
    console.log(recipe.smallImageUrls[0]);
  };

}
