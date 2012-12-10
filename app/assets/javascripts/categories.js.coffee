# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
# par.first(".new_sub_category").html(data);

$(".edit-item").live "ajax:success", (event, data, status, xhr) =>
	if event.target.dataset['typebtn'] == "cancel" 
		back_to_list(event, data,"main-list")
	else
		back_to_list(event, data,"home")
	show_tab('first')

show_tab = (x) ->
	$("#mainTab li:#{x} a").tab('show')

$('.auto-hide').live "hover", (ev) ->
	if ev.type == "mouseenter"
		$(this).children('a:first').children('.icon-flag').parent().show()
	if ev.type == "mouseleave"
		$(this).children('a:first').children('.icon-flag').parent().hide()
	
	
back_to_list = (event, data, target) ->
	$("##{target}").html(data)
	$('#note-list span').hide()
	$('tr[data-linknote]').live "hover", 
		(e) => 
			$('#note-list span').hide()
			$linknote = e.target.parentNode.dataset["linknote"]
			$('#'+$linknote).show()
			$('#item-list .nav-tabs a:eq(1)').attr("href", "/hosts/"+$linknote.split("-")[1])
			$('#item-list .nav-tabs a:last').attr("href", "/conx/"+$linknote.split("-")[1])
			
$('#item-list .nav-tabs a').live "ajax:success", (event, data, status, xhr) =>
	$tag = $(event.target).attr("data-target")
	$($tag+' div').html(data)
	
$("#new-form").live "ajax:success", (event, data, status, xhr) =>
	$("#new-edit-pane").html(data)

$("#search-results").live "ajax:success", (event, data, status, xhr) =>
	$('#search-results div').html(data)
	
$(".new-category").live "ajax:success", (event, data, status, xhr) =>
	$("#main-list").html(data)
	
$(".load-sub-category").live "ajax:success", (event, data, status, xhr) =>
	back_to_list(event, data,"main-list")
			
$('.menu-item ul[data-linknote] a').live "ajax:success", (event, data, status, xhr) =>
	$target = $(event.target.dataset['target'])
	$target.html(data)
	console.log("target id = " + $target.attr("id"))
	if $target.attr("id") == "new-edit-pane" 
		show_tab('last')
	else
		back_to_list(event, data,"main-list")
		show_tab('first')
	
$('td.auto-hide > a').live "ajax:success", (event, data, status, xhr) =>
	$("#main-menu div:first").html(data)
	$tag = $(event.target)
	if $tag.children('i').hasClass("icon-flag")
		$tag.children('i').removeClass("icon-flag").addClass("icon-tag")
		$tag.attr("href",$tag.attr("href").replace(true,false))
	else
		$tag.children('i').removeClass("icon-tag").addClass("icon-flag")
		$tag.attr("href",$tag.attr("href").replace(false,true))
	console.log($tag.attr("href"))