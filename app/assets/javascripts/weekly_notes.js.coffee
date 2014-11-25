# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "ready", ->

  # STYLE
  #$('#divFPat_Search').hide()
  # $('#meeting_date, #sPreviousMeetings').prop('disabled', true)


  # SELECTS
  $('#s_weekly_ward').change ->
    $('#divFPat_Search').show()
    $('#meeting_date').val("")
    $('#fMeetings').submit()
    $('#t_ward').val($(this).val())

    # $('#meeting_date, #sPreviousMeetings').prop('disabled', false)
    # $('#meeting_date').show()
    # alert 'after submit'

  $('#sPreviousMeetings').change ->
    alert 'previous meetings'

  # In: meetingtracker.html.erb
  $('#q_patient_ward_eq, #q_drugs_last_changed_eq').change ->
    $('#fWeeklyFilter').submit()


  # DATEPICKERS
  $('#meeting_date').change ->
  	# alert 'change the date'
  	$('#sPreviousMeetings').val("")
  	$('#pat_search').submit()

  # In: meetingtracker.html.erb
  $('#q_meeting_date_gteq, #q_meeting_date_lteq, #q_pre_date_gteq, #q_pre_date_lteq, #q_patient_doa_gteq, #q_patient_doa_lteq').change ->
    $('#fWeeklyFilter').submit()

  # TABLES 
  # In: _meetingtrackertable.html.erb
  $('#meetingtrackertable tbody')
    .on 'click', 'tr', ->
      patid = $('td', this).eq(0).html()
      # alert(patid)
      $('#id').val(patid)
      $('#fForPatNotes').submit()
      # $.ajax(
      #   url: "/weekly_notes/"+id+"/tracker_patnotes",
      #   type: "GET"
      #   dataType: "json"
      # ).done (data) ->
      #   alert('here in js')
      #   alert(data)
      #   $('#divPats').append data.id

  # RANSACK FILTER
    $('#fWeeklyFilter').submit ->
      # alert 'filter submit'
      $('#divTrackerPatNotes').html("<strong>Past Notes</strong>")





    # $('#pat_search').submit (event) ->
    #   alert 'submit form'
  
