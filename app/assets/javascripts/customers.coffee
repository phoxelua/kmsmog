# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# jQuery ->
#   # logic for dependent dropdowns: https://www.youtube.com/watch?v=jO5SpYctA-s
#   models = $('.model-dropdown').find("select").html()
#   $('.make-dropdown').change ->
#     make = $('.make-dropdown :selected').text()
#     escaped_make = make.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')
#     options = $(models).filter("optgroup[label='#{escaped_make}']").html()

#     if options
#       $('.model-dropdown').find("select").html(options)
#       $('.model-dropdown').find("select").parent().show()
#     else
#       $('.model-dropdown').find("select").empty()

# jQuery ->
#   $('.make-dropdown').change ->
#     console.log('make changed')
#     $('.model-dropdown > .selectize-control > .selectize-input').click()    
#     # $('.model-dropdown > .selectize-control > .selectize-input').click ->
#     models = $('.selectize-dropdown.model-d > .selectize-dropdown-content > .optgroup').html()
#     console.log(models)
#     make = $('.selectize-dropdown.make-d > .selectize-dropdown-content > .selected ').text()
#     console.log(make)
#     escaped_make = make.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')
#     console.log(escaped_make)
#     console.log("[data-group='#{make}']")
#     options = $("[data-group='#{make}']").html()
#     console.log(options)

#     if options
#       $('.selectize-dropdown.model-d > .selectize-dropdown-content').html(options)
#       $('.selectize-dropdown.model-d > .selectize-dropdown-content').parent().show()
#     else
#       $('.selectize-dropdown.model-d > .selectize-dropdown-content').empty()


