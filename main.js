var RecipeGenerator = new function(){
  var db = data;
  var current_ans = "";

  this.init = function(){
    $("#guess-submit").click(function(){
      _checkAnswer();
    });
    _random_recipe();
    $('input[type=text]').on('keyup', function(e) {
      if (e.which == 13) {
        e.preventDefault();
        _checkAnswer();
      }
    });
  }

  function _random_recipe(){
    random_recipe = db[Math.floor(Math.random()*db.length)]
    _set_recipe(random_recipe);
    console.log("GEN NEW ONE");
  };

  function _set_recipe(recipe){
    img_url = recipe.image_url
    if (img_url != undefined) {
      img_url= img_url.replace("s90-c", "l90-c")
    }
    $("#guess-image").attr("src", img_url);
    bg_url = "background-image: url('" + img_url + "')"
    $("#background-image").attr("style", bg_url);
    current_ans = recipe.calories;
    console.log(current_ans);
  };

  function _checkAnswer(){
    console.log("Guessed");
    ans = parseInt($("#guess-text").val());
    console.log("ANS:" + ans);
    console.log("CORRECT ANS:" + current_ans);
    if (ans == current_ans){
      $("#spot-on").fadeIn().delay(500).fadeOut();
      _random_recipe();
      $("#guess-text").val("");
    } else if ((ans < current_ans*1.1) && (ans >= current_ans*0.9)){
      console.log("CORRECT");
      $("#correct").fadeIn().delay(500).fadeOut();
      _random_recipe();
      $("#guess-text").val("");
    } else {
      $("#incorrect").fadeIn().delay(500).fadeOut();
    }
  };
}

$(document).ready(function(){
  RecipeGenerator.init();
});
