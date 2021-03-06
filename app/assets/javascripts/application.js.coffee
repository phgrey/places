# This is a manifest file that'll be compiled into application.js, which will include all the files
# listed below.
#
# Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
# or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
#
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# the compiled file.
#
# WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
# GO AFTER THE REQUIRES BELOW.
#
#= require jquery
# require jquery_ujs
# require twitter/bootstrap
#= require_tree .


jQuery ->
  if $(window).width() > 768
    $('.masonry').masonry({
      itemSelector: '.masonry > div'
      autoGutter: true
      isFluid: true
#      theese functions can be only used to save the width and margin percents for the span4 (3x-column)
#      columnWidth: ( w ) -> w*0.31623931623931625
#      gutterWidth: ( w ) -> w*0.02564102564102564
    isResizable: true
    })#.masonry 'reload'#this is working correctly for the first time for now

#Working with the map
jQuery(window).load ->
  svgobject = document.getElementById('map_o')
  svgdom = jQuery(svgobject.contentDocument);
  jQuery("#polygon30",svgdom).css({'fill':'#d1caca'})
  jQuery("#path90",svgdom).css({'fill':'#d1caca'})
  jQuery("#path82",svgdom).css({'fill':'#d1caca'})
  jQuery("#path60",svgdom).css({'fill':'#d1caca'})
  svg_fill = '';
  timeoutId = '';
  jQuery("polygon", svgdom).click(
    ->
      goToCity($(this))
  )
  jQuery("path", svgdom).click(
    ->
      goToCity($(this))
  )
  jQuery("polygon", svgdom).hover(
    ->
      svg_fill =  $(this).css('fill')
      id = $(this).attr('id');
      $(this).css({'cursor':'pointer','fill':'#ffdf49'})
      fade = ->
          $('#area #'+id).fadeIn("slow");
      timeoutId = setTimeout fade, 500
    ->
      clearTimeout(timeoutId);
      id = $(this).attr('id');
      $(this).css({'fill':svg_fill})
      $('#area #'+id).fadeOut("fast");
  )
  jQuery("path", svgdom).hover(
    ->
      svg_fill =  $(this).css('fill')
      id = $(this).attr('id');
      $(this).css({'cursor':'pointer','fill':'#ffdf49'})
      fade = ->
        $('#area #'+id).fadeIn("slow");
      timeoutId = setTimeout fade, 500
    ->
      clearTimeout(timeoutId);
      id = $(this).attr('id');
      $(this).css({'fill':svg_fill})
      $('#area #'+id).fadeOut("fast");
  )
goToCity =(thiss) ->
  id = thiss.attr('id');
  window.location.href = $('#area #'+id).parent().attr('href');
# end working with the map




### we will need this when tabs will be needed on forms
  $('fieldset.make-me-tabs').each (num)->
    errs = $(@).find('.control-group').hide().filter('.error').length > 0
    par=$('<div>', {class:'tabbable control-group'})
      .append(ul=$('<ul>', {class:'nav nav-tabs'}))
      .append(div=$('<div>', {class:'tab-content'}))
    par.addClass('error') if errs
    $(@).find('label').appendTo(ul).wrap('<li>').wrap('<a>').parent().each (i)->
      $(@).attr({'data-toggle': 'tab', 'href':'#t'+num+'_'+i})
    .parent().first().addClass('active')
    $(@).find('.controls').appendTo(div).addClass('tab-pane').each (i)->
      $(@).attr({'id':'t'+num+'_'+i})
    .first().addClass('active')
    par.find('.help-inline').appendTo(div)
    par.insertBefore($(@).find('.control-group').first()).tab "show"
###

