# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "ready", ->
  # alert 'when does this go on'

  # Get facility Value to pass to Facility select
  facValue = $('#for_select_facility').val()
  $('#sFor_select_facility').val(facValue)

  # Pass Facility select value to hidden facility text when it changes
  $('#sFor_select_facility').change ->
    newFacValue = $(this).val()
    $('#for_select_facility').val(newFacValue)