var RecipeGenerator = new function(){
  var db = data;

  this.random_recipe = function(){
    random_recipe = db[Math.floor(Math.random()*db.length)]
    this.set_recipe(random_recipe);
  };

  this.set_recipe = function(recipe){
    img_url = recipe.smallImageUrls[0];
    if (img_url != undefined) {
      img_url= img_url.replace(".s.png", ".xl.png")
    }
    $("#guess-image").attr("src", img_url);
    $("#guess-name").text(recipe.recipeName);
    console.log(recipe.smallImageUrls[0]);
  };

}

$(document).ready(function(){
  RecipeGenerator.random_recipe();
});
