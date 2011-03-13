// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

// Proposal#new
function add_fields(link, association, content) {
	var new_id = new Date().getTime();
	var regexp = new RegExp("new_" + association, "g")
	$("#document-list").append(content.replace(regexp, new_id));
}

// assignment_index
var draggableOptions = {revert: 'invalid'};
var droppableOptions = {
	activeClass: 'drag-active',
	hoverClass: 'drag-hover',
	drop: function(event, ui) {
		$(this).effect("highlight", {}, 700);
		var newDraggable = $("<li user_id='" + ui.draggable.attr('user_id') + "' class='draggable'></li>").text(ui.draggable.text());
		newDraggable.draggable(draggableOptions);
		$(this).append(newDraggable);
		ui.draggable.remove();
		
		//Enable'Save Changes' button
		$('#assignments-save').attr('disabled', '');
	}
}

$(document).ready(function() {
	$('.draggable').draggable(draggableOptions);
	$('.available-reviewers, .proposal-reviewers').droppable(droppableOptions);
	
	$('#assignments-save').click(function() {
		//the json object to be sent to server
		var pack = {
			proposals: []
		}
		
		//iterate each proposal on current page
		$('tr:not(:first)').each(function(i) {
			var proposal = {
				reviewers: []
			};
			
			//set attributes
			proposal.id = $(this).attr('proposal_id');
			
			//iterate each reviewer
			$('.proposal-reviewers li', this).each(function(i) {
				proposal.reviewers.push($(this).attr('user_id'));
			});
			
			//add proposal to the pack
			pack.proposals.push(proposal)
		});
		
		//send json to server
		$.ajax({
			type: "POST",
			url: '/assignments/multi_update.json',
			data: { _method: 'PUT', data: JSON.stringify(pack) },
			dataType: 'json',
			beforeSend: function() {
				$('#load-ball').fadeIn();
			},
			complete: function() {
				$('#load-ball').fadeOut();
				$('#assignments-save').attr('disabled', 'disabled');
			}
		});
		
		return false;
	});
});