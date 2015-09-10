# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  # $('#trip_start_date').datepicker
  #   dateFormat: 'mm-dd-yy'
  # $('#trip_end_date').datepicker
  #   dateFormat: 'mm-dd-yy'

$ ->
  $('#trip_start_date').datepicker
    defaultDate: '+1w'
    changeMonth: true
    numberOfMonths: 2
    onClose: (selectedDate) ->
      $('#trip_end_date').datepicker 'option', 'minDate', selectedDate
      return
  $('#trip_end_date').datepicker
    defaultDate: '+1w'
    changeMonth: true
    numberOfMonths: 2
    onClose: (selectedDate) ->
      $('#trip_start_date').datepicker 'option', 'maxDate', selectedDate
      return
  return
