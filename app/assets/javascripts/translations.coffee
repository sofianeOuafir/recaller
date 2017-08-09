# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


@displayTranslationForm = (action) ->
    if action == "show"
      $('.add-translation-form').show("fast") unless $('.add-translation-form').is(':visible')
    else
      $('.add-translation-form').hide("fast") if $('.add-translation-form').is(':visible')

ready = ->
  $("a[data-translation_form]").click (e) ->
    e.preventDefault()

    action = $(this).data("translation_form")
    displayTranslationForm(action)

$(document).on "turbolinks:load", ->
  ready()





