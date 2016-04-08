# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$ ->
  $('#entries').imagesLoaded ->
    $('#entries').masonry
      itemSelector: '.box'
      isFitWidth: true
  $('#entries').infinitescroll {
    navSelector: '.pagination'
    nextSelector: '.pagination a'
    itemSelector: '.box'
    loading:
      finishedMsg: ''
      img: ''
  }, (newElements) ->
    $newElems = $(newElements).css(opacity: 0)
    $('#entries').append($newElems).imagesLoaded ->
      $newElems.animate opacity: 1
      $('#entries').masonry 'appended', $newElems
      return
    return
  return