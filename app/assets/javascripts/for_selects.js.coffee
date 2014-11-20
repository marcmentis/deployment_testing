# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "ready", ->
  # alert 'when does this go on'

  # Get facility Value to pass to Facility select
  facValue = $('#for_select_facility').val()
  alert(facValue)
  # Set text value
  $('#sFor_select_facility option:selected').text(facValue)
  # $('#sFor_select_facility').prop('text', facValue);
  # $('#sFor_select_facility').val(facValue)

  # Pass Facility select value to hidden facility text when it changes
  $('#sFor_select_facility').change ->
  	# Get text value
    newTextValue = $('#sFor_select_facility option:selected').text()
    # newTextValue = $(this option:selected).text()
    alert(newTextValue)
    # $('#for_select_facility').val(newFacValue)