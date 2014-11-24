# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "ready", ->

  # SELECTS
  $('#q_facility_eq, #q_ward_eq, #q_doa_gteq, #q_doa_lteq').change ->
    $('#fPatient_filter').submit()
