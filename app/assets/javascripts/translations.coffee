# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

root = exports ? this
root.showTranslationForm = () ->
    $('.add-translation-form').show("fast") unless $('.add-translation-form').is(':visible')

root.hideTranslationForm = () ->
    $('.add-translation-form').hide("fast") if $('.add-translation-form').is(':visible')
    return false



