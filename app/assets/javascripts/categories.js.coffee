# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
# par.first(".new_sub_category").html(data);

$(".edit-item").live "ajax:success", (event, data, status, xhr) =>
	console.log("on passe dans 1")
	$("#main-list").html(data)

show_tab = (x) ->
	console.log("on passe dans 2")
	$("#mainTab li:#{x} a").tab('show')
	
back_to_list = (event, data, target) ->
	console.log("on passe dans 4")
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
	console.log("on passe dans 5")
	$tag = $(event.target).attr("data-target")
	$($tag+' div').html(data)


$("#search-results").live "ajax:success", (event, data, status, xhr) =>
	console.log("on passe dans 6")
	$("#results").html(data)

	
$(".new-category").live "ajax:success", (event, data, status, xhr) =>
	console.log("on passe dans 7")
	$("#main-list").html(data)
	
$(".load-sub-category").live "ajax:success", (event, data, status, xhr) =>
	console.log("on passe dans 8")
	back_to_list(event, data,"main-list")
			
$('.menu-item ul a').live "ajax:success", (event, data, status, xhr) =>
	console.log("on passe dans 9")
	$target = $(event.target.dataset['target'])
	$target.html(data)
	console.log("target id = " + $target.attr("id"))
	if $target.attr("id") == "new-edit-pane" 
		show_tab('last')
	else
		back_to_list(event, data,"main-list")
		show_tab('first')

$("#new-form").live "ajax:success", (event, data, status, xhr) =>
	console.log("on passe dans 10")
	show_tab('last')
	$("#new-edit-pane").html(data)
		
$('a.fill-target').live "ajax:success", (event, data, status, xhr) =>
	console.log("on passe dans 11")
	$($(event.target).attr("data-target")).html(data)

$('a.swap').live "ajax:success", (event, data, status, xhr) =>
	console.log("on passe dans 12")
	$("#main-menu div:first").html(data)
	$tag = $(event.target)
	if $tag.children("b").hasClass("icon-flag")
		$tag.children("b").removeClass("icon-flag").addClass("icon-tag")
		$tag.attr("href",$tag.attr("href").replace(true,false))
	else
		$tag.children("b").removeClass("icon-tag").addClass("icon-flag")
		$tag.attr("href",$tag.attr("href").replace(false,true))
	console.log($tag.attr("href"))
		
