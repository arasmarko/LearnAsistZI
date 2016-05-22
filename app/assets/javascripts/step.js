$(document).on('click', '.js-add_step', function (e) {

	var goalId = $(this).data('goal-id'); 

	$.ajax({
		type: 'GET',
		url: '/step/new',
		data: {goalId: goalId},
		}).success(function(data) {
			$('.steps').prepend(data.html_content);
			$('.js-add_step').hide();
		});

})

$(document).on('click', '.js-save__added_steps', function (e) {

	e.preventDefault()

	$('input').each( function(element, index) {
		console.log(this)
	});

	$.ajax({
		type: 'POST',
		url: '/step/new',
		data: data,
		}).success(function(data) {
			$('.js-add_step').show();
		});

})

$(document).on('click', '.js-add-todo', function (e) {

	var stepId = $(this).data('step-id'); 

	$.ajax({
		type: 'GET',
		url: '/todo/new',
		data: {stepId: stepId},
		}).success(function(data) {
			$('.new_todo').append(data.html_content);
		});

})