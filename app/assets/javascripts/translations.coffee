# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


@displayTranslationForm = (action) ->
    if action == "show"
      $('.add-translation-form').show("fast") unless $('.add-translation-form').is(':visible')
    else
      $('.add-translation-form').hide("fast") if $('.add-translation-form').is(':visible')


@hideAndShow = (element) ->
  	if element.is(":visible")
      element.hide("fast")
    else
      element.show("fast")


ready = ->
  $("a[data-translation_form]").click (e) ->
    e.preventDefault()

    action = $(this).data("translation_form")
    displayTranslationForm(action)

  $("a[data-display]").click (e) ->
    e.preventDefault()
    element = $(this).data("display")
    hideAndShow($("#" + element))

  $("#archived_supports").hide()
    


$(document).on "turbolinks:load", ->
  ready()





