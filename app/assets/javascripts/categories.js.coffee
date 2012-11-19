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
	
back_to_list = (event, data, target) -> 
	$("##{target}").html(data)
	$('#note-list span').hide()
	$('tr[data-linknote]').live "hover", \
		(e) => 
			$('#note-list span').hide()
			$("#"+e.target.parentElement.dataset['linknote']).show()

$("#new-form").live "ajax:success", (event, data, status, xhr) =>
	$("#new-edit-pane").html(data)

$(".new-category").live "ajax:success", (event, data, status, xhr) =>
	$("#main-list").html(data)
	
$(".load-sub-category").live "ajax:success", (event, data, status, xhr) =>
	back_to_list(event, data,"main-list")
			
$('tr[data-linknote] a').live "ajax:success", (event, data, status, xhr) =>
	$target = $(event.target.dataset['target'])
	$target.html(data)
	console.log("target id = " + $target.attr("id"))
	if $target.attr("id") == "new-edit-pane" 
		show_tab('last')
	else
		show_tab('first')
	



	