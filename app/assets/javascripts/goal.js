window.onload = function onLoad() {

	$('.progress_bar_done').each(function(i, obj) {
		stepId= obj.classList[1];
		console.log(obj.classList[1])

		$.ajax({
			type: 'GET',
			url: '/step/get-progress',
			data: {stepId: stepId}
			}).success(function(data) {
				$('#step-'+data.stepId).animate({left: 0, width: data.progress+'%'});
		});
	});
    
    
};


$(document).on('click', '.js-add_goal', function (e) {
	$.ajax({
		type: 'GET',
		url: '/goal/new',
		}).success(function(data) {
			openModal();
			$('.custom-modal').append(data.html_content);
		});
})

$(document).on('click', '.js-add-step__from-goal', function (e) {

	$(this).parent().parent().find('.goal__card__step__new').show();
	$(this).hide();
})


$(document).on('click', '.close-add-step__from-goal', function (e) {
	$('.goal__card__step__new').hide();
	$('.js-add-step__from-goal').show();
})



$(document).on('click', '.js-post-add-step__from-goal', function (e) {

	$stepName = $('.step_name').val();
	$('.step_name').hide();
	$(this).hide();
	$(this).siblings('.close-add-step__from-goal').remove();
	$('.step_added').html($stepName).show();
	var goalId = $('.step_name').data('goalid');
	$('.js-add-step__from-goal').show();

	$.ajax({
		type: 'POST',
		url: '/step/new_from_goal',
		data: {
			goalId: goalId,
			name: $stepName
		},
		}).success(function(data) {
			$('.step_added').attr('href', '/goal/step/'+data.stepId);
			window.location = window.location;
		});

})

$(document).on('click', '.js-todo-check', function (e) {
	if($(this).is(':checked')){
		console.log('da');
	    var todoId = $(this).data('todo-id');
	    console.log($('*[data-todo-id='+todoId+']').css('textDecoration', 'line-through'));

	    $.ajax({
	    	type: 'POST',
	    	url: '/todo/check',
	    	data: {todoId: todoId},
	    	}).success(function(data) {
	    		console.log(data);
	    		$('#step-'+data.stepId).animate({left: 0, width: data.progress+'%'});
	    });

	} else {
	    console.log('ne');
	    var todoId = $(this).data('todo-id');
	    console.log($('*[data-todo-id='+todoId+']').css('textDecoration', 'none'));
	    $.ajax({
	    	type: 'POST',
	    	url: '/todo/uncheck',
	    	data: {todoId: todoId},
	    	}).success(function(data) {
	    		console.log(data);
	    		$('#step-'+data.stepId).animate({left: 0, width: data.progress+'%'});
	    	});
	}
});

















