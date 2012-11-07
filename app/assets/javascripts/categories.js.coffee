# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
# par.first(".new_sub_category").html(data);

# On ajoute le comportement au composant de classe my-icon-plusminus
# soit on ajoute la grille de saisie, soit on la retire	
$(".my-icon-plusminus").live "ajax:success", (event, data, status, xhr) =>
	element = $(event.target)
	if element.hasClass("ui-icon-circle-plus")
		element.removeClass("ui-icon-circle-plus").addClass("ui-icon-circle-minus")
		element.parent().append(data);
	else	
		element.parent().children(".new_sub_category").remove()
		element.removeClass("ui-icon-circle-minus").addClass("ui-icon-circle-plus")

# On ajoute le comportement a notre grille de saisie
# En fin de saisie, on reactualise la page (partial)
$("#new_sub_category").live "ajax:success", (event, data, status, xhr) =>
	element = $(event.target).parent().parent().parent()
	element.html(data)

$("#hide_sub_category").live "ajax:success", (event, data, status, xhr) =>
	$("#new_sub_category").html("")

$(".load-sub-category").live "ajax:success", (event, data, status, xhr) =>
	$("#sub-categories-list").html(data)
	
	
	