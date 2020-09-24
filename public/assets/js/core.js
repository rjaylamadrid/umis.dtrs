let path = document.location.href;

async function f (data = {}, type = 'json', url = path) {
  const response = await fetch(url, {
    method: 'POST',
    body: new URLSearchParams(data),
    headers: new Headers({ 'Content-type': 'application/x-www-form-urlencoded; charset=UTF-8' }),
  });
  return type == 'json' ? response.json() : response.text();
}

// START::ATTENDANCE
function init_dtr(id) {
  $("#cover-spin").show(0);
  if (id == 0) {
    $("#dtr").html("");
    $("#cover-spin").hide(0);
  } else {
    var month = document.getElementById("month").value;
    var year = document.getElementById("year").value;
    var period = document.getElementById("period").value;

    f({action: 'get_attendance', id:id, month:month, year:year, period:period}, "text").then( function(html){
      $("#dtr").html(html);
    });
  }
}
// ATTENDANCE::END

// EMPLOYEE PROFILE :: START
function show_collapse(id) {
  if($('#'+id).hasClass('collapse')){
    $('#'+id).removeClass('collapse');
    $('.'+id).removeClass('fe-chevron-down');
    $('.'+id).addClass('fe-chevron-up');
  }else{
    $('#'+id).addClass('collapse');
    $('.'+id).addClass('fe-chevron-down');
    $('.'+id).removeClass('fe-chevron-up');
  }
}

function confirm_delete(no) {
  alert("R u sure ba?" + no);
}
// EMPLOYEE PROFILE :: END

// OTHER FUNCTIONS :: START
function colours(size) {
  var color = [];
  var chartColors = [
    "rgb(255, 99, 132)",
    "rgb(255, 159, 64)",
    "rgb(255, 205, 86)",
    "rgb(75, 192, 192)",
    "rgb(54, 162, 235)",
    "rgb(153, 102, 255)",
    "rgb(201, 203, 207)",
  ];
  for (let i = 0; i < size; i++) {
    color.push(chartColors[i]);
  }
  return color;
}

function init_pos(type) {
  if(type == 3){
    type = 2;
  }else if(type == 4) {
    type = 1;
  }
  f({action: 'get_position', type:type}, "json", "/employees").then( function(positions){
    $('#positions').html("<option selected disabled>Position</option>");
    positions.forEach(function (position){
        $('#positions').append("<option value='" + position['no'] + "'>" + position['position_desc'] + "</option>");
    });
  });
}

function set_new (new_emp) {
  if (new_emp) {
    $('#employee_id').attr('readonly',true);
    f({action: 'new_id'}, "text", "/employees").then( function(id){
      $('#employee_id').val(id);
    });
  } else {
    $('#employee_id').val('');
    $('#employee_id').attr('readonly',false);
  }
}

function get_schedule (sched_code) {
  if (sched_code === "create"){
    $("#create-schedule-modal").modal('show');
  }else{
    f({action: 'get_schedule', sched_code:sched_code}, "text", "/employees").then( function(html){
      $("#schedule").html(html);
    });
  }
}

function get_salary () {
  var position = $('#positions').val();
  var date = $('#date-start').val();
  var campus = $('#campus').val();
  f({action: 'get_salary', position_id:position, date_start:date, campus_id:campus}, "text", "/employees").then( function(html){
    $('#salary').val("Php " + html.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,'));
    console.log("Php " + html.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,'));
  });
}
// OTHER FUNCTIONS :: END