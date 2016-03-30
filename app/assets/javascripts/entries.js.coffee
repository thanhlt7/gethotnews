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
    # hide new items while they are loading
    $newElems = $(newElements).css(opacity: 0)
    # ensure that images load before adding to masonry layout
    $newElems.imagesLoaded ->
      # show elems now they're ready
      $newElems.animate opacity: 1
      $('#entries').masonry 'appended', $newElems, true
      return
    return
  return