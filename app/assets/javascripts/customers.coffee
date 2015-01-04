# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# jQuery ->
# 	models = $('.make-dropdown').find(".form-control").html()
jQuery ->
  $('.model-dropdown').find("select").parent()
  models = $('.model-dropdown').find("select").html()
  $('.make-dropdown').change ->
    make = $('.make-dropdown :selected').text()
    escaped_make = make.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')
    options = $(models).filter("optgroup[label='#{escaped_make}']").html()

    if options
      $('.model-dropdown').find("select").html(options)
      $('.model-dropdown').find("select").parent().show()
    else
      $('.model-dropdown').find("select").empty()
