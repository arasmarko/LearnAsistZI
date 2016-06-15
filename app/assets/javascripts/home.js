var zero = true;
var progress = true;
var finished = true;
var range = [true,true,true];

$( document ).on('page:ready page:change', function() {

  populateProgress();

});



$(document).on('click', 'input', function (argument) {
    var searchStarted = $('.js-searchStarted').prop("checked");
    var searchWorking = $('.js-searchWorking').prop("checked");
    var searchFinished = $('.js-searchFinished').prop("checked");

    console.log($('.js-searchWorking').prop("checked"))

    zero = true;
    progress = true;
    finished = true;

    if (!searchStarted) {
      range[0] = false;
    }
    if (!searchWorking) {
      range[1] = false;
    }
    if (!searchFinished) {
      range[2] = false;
    }
    if (searchStarted) {
      range[0] = true;
    }
    if (searchWorking) {
      range[1] = true;
    }
    if (searchFinished) {
      range[2] = true;
    }

    console.log(range)

    $('.goal__content__home__card_up__status').each(function (element, index) {

       var status = parseInt($(this).text().slice(0, -1));

       if (status == 0 && !range[0]) {
        console.log('hide 0')
          $(this).parent().parent().hide();

       } else if (status == 100 && !range[2]) {
        console.log('hide 100')
          $(this).parent().parent().hide();

       } else if (status != 0 && status != 100 && !range[1]) {
        console.log('hide 50: ', status, status == 100)
          $(this).parent().parent().hide();

       } else if (status == 0 && range[0]) {
        console.log('show 0')
          $(this).parent().parent().show();
       } else if (status == 100 && range[2]) {
          console.log('show 100')
          $(this).parent().parent().show();
       } else if (status != 0 && status != 100 && range[1]) {
        console.log('show 50')
          $(this).parent().parent().show();
       }

    })
})

function populateProgress () {
   var length = $('.goal__content__home').data('length');
   var progresses = [];

   function getArr(callback) {
      for (var i = 1; i < length+1; i++) {
        var goal = $('#circle'+i).data('goal');

        $.ajax({
          type: 'GET',
          async: false,
          url: '/goal/get-progress',
          data: {goal: goal}
          }).success(function(data) {
            progresses.push(data.progress)
            if (progresses.length == length) {
              callback();
            }
            
        });
      }
   }

   getArr(function () {

      for (var i = 1; i < length+1; i++) {

        var goal = $('#circle'+i).data('goal');
        $('#circle'+i).next().text(parseInt(progresses[0]*100)+'%');

        $('#circle'+i).circleProgress({
            value: progresses.shift(),
            size: 140,
            fill: {
                gradient: ["#DDF21D", "#1EED13"]
            },
            startAngle: 90
        });
      }
   }) 
}













