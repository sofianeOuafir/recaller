showVerticalOption = ->
  $(".data-row").hover \
    (-> $(this).find(".glyphicon-option-vertical").css("display", "inline-block")), \
    (-> $(this).find(".glyphicon-option-vertical").css("display", "none"))

window.showVerticalOption = showVerticalOption

$(document).on "turbolinks:load", ->
  showVerticalOption()