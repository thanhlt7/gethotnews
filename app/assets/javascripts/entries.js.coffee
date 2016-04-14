# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$ ->
  $('#entries').imagesLoaded ->
    $('#entries').masonry
      itemSelector: '.box'
      isFitWidth: true
   $(window).bind 'scroll', ->
    if $(window).scrollTop() > 50
      $('nav').addClass 'navbar-fixed-top'
    else
      $('nav').removeClass 'navbar-fixed-top'
    return   
    
  $('#entries').infinitescroll {
    navSelector: '.pagination'
    nextSelector: '.pagination a'
    itemSelector: '.box'
    loading:
      finishedMsg: ''
      img: ''
  }, (newElements) ->
    $newElems = $(newElements).css(opacity: 0)
    $newElems.imagesLoaded ->
      $newElems.animate opacity: 1
      $('#entries').masonry 'appended', $newElems, true
    return
   return
  return