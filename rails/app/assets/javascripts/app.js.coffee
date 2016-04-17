app = angular.module 'quizmaster', []

app.service 'Color', ->
  color = {}
  color_font = "black"

  color.get = ->
    return color_font

  color.set = (new_color) ->
    color_font = new_color
    return color_font

  return color

app.controller 'changecolorCtrl', ($scope, Color) ->
  
  $scope.color = Color.get();

  $scope.violet = -> 
    $scope.color = Color.set("#aa00ff");
  
  $scope.green = ->
    $scope.color = Color.set("#67a977");

  $scope.red = ->
    $scope.color = Color.set("#B40F20");

  $scope.black = ->
    $scope.color = Color.set("black"); 

  $scope.pink = ->
    $scope.color = Color.set("#ff00aa");