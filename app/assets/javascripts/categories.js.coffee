# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
# par.first(".new_sub_category").html(data);

back_to_list = (event, data, target) -> 
	$("##{target}").html(data)
	$('#note-list span').hide()
	$('tr[data-linknote]').hover \
		(e) => 
			$('#note-list span').hide()
			$("#"+e.target.parentElement.dataset['linknote']).show()
		
show_tab = (x) ->
	$("#categoryTab li:#{x} a").tab('show')

$("#new-c-sc").live "ajax:success", (event, data, status, xhr) =>
	$("#new-sub-category-pane").html(data)
	
$(".new_sub_category").live "ajax:success", (event, data, status, xhr) =>
	if event.target.dataset['typebtn'] == "cancel" 
		back_to_list(event, data,"main-category")
	else
		back_to_list(event, data,"home")
	show_tab('first')
		
$(".new-category").live "ajax:success", (event, data, status, xhr) =>
	$("#main-category").html(data)
		
$(".edit_sub_category").live "ajax:success", (event, data, status, xhr) =>
	back_to_list(event, data,"home")
	show_tab('first')
		
$(".load-sub-category").live "ajax:success", (event, data, status, xhr) =>
	back_to_list(event, data,"main-category")
	back_to_list()
			
$('tr[data-linknote] a').live "ajax:success", (event, data, status, xhr) =>
	$(event.target.dataset['target']).html(data)
	show_tab('last')


	