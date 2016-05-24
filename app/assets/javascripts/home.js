$( document ).ready(function() {

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
           console.log('set push for: ', data);
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
       console.log('init: ', progresses[0]*100);
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

});