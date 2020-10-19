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
  var from, to;
  $("#cover-spin").show(0);
  if (id == 0) {
    $("#dtr").html("");
    $("#cover-spin").hide(0);
  } else {
    var month = document.getElementById("month").value;
    var year = document.getElementById("year").value;
    var period = document.getElementById("period").value;
    switch(period) {
      case '1':
        from = create_date(year+'-'+month+'-01');
        to = create_date(year+'-'+month+'-15');
        break;
      case '2':
        from = create_date(year+'-'+month+'-16');
        to = create_date(year+'-'+month+'-01', 'month');
        break;
      case '4':
        from = document.getElementById("date_from").value;
        to = document.getElementById("date_to").value;
        break;
      default:
        from = create_date(year+'-'+month+'-01');
        to = create_date(year+'-'+month+'-01', 'month');
        break;
    }
    f({action: 'get_attendance', id:id, date_from:from, date_to:to, period:period}, "text").then( function(html){
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

function confirm_delete(no, id, tab, other_info_col='', other_info_data='', admin_id='') {
  if(confirm("Are you sure you want to delete this record?")) {
    if(tab=='other-info') {
      f({action: 'delete_row', no:no, tab:tab, other_info_col:other_info_col, other_info_data:other_info_data, admin_id:admin_id}, "text", "/employees").then( function (data) {
        location.href = "/employees/profile/" + id + "/" + tab;
      });
    }
    else if(tab=='service_record') {
      f({action: 'delete_row', no:no, tab:'status'}, "text", "/employees").then( function (data) {
        location.href = "/employees/employment-update/" + id + "/" + tab;
      });
    }
    else {
      f({action: 'delete_row', no:no, tab:tab}, "text", "/employees").then( function (data) {
        location.href = "/employees/profile/" + id + "/" + tab;
      });
    }
  }
}
// EMPLOYEE PROFILE :: END

// CALENDAR :: START
  function get_events(day,month,year) {
    day = (day < 10 ? "0" : "") + day;
    month = (month < 10 ? "0" : "") + month;
    document.getElementById('event_date').value = year+'-'+month+'-'+day;
    f({action: 'get_events', day:day, month:month, year:year}, "text", "/calendar/show-events").then( function (data) {
      $('#tbl-event').html(data);
      console.log(data);
    });
  }
// CALENDAR :: END

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
  f({action: 'get_position', type:type}, "json", "/employees").then( function (positions) {
    // console.log(type);
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
    f({action: 'get_schedule', sched_code:sched_code}, "text", "/employees").then( function (html) {
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
  });
}

function customDate (is_custom) {
  if (is_custom == "4") {
    $('#preset').addClass("d-none");
    $('#custom').removeClass("d-none");
  } else {
    $('#preset').removeClass("d-none");
    $('#custom').addClass("d-none");
  }
}

function set_from (from) {
  $('#to').attr('min',create_date (from,'day', 1));
  $('#to').attr('max',create_date (from, 'day',30));
  $('#to').attr('value',create_date (from, 'day',30));
}

function create_date (date, range_type = 'day', range = 0) {
  var dt = new Date (date);
  var y = dt.getFullYear();
  var m = dt.getMonth() + 1;
  var d = dt.getDate();
  if (range_type == 'day') {
    dt.setDate(dt.getDate() + range);
  } else if (range_type == 'month') {
    dt = new Date(y, m, 0);
  }
  y = dt.getFullYear();
  m = dt.getMonth() + 1;
  d = dt.getDate();
  return y + '-' + (m >= 9 ? m : '0'+ m) + '-' + (d >= 9 ? d : '0'+ d); 
}

function create_sched (ctr) {
  if(document.getElementById("day"+ctr).checked) {
    $("#amin"+ctr).show(0);
    $("#amout"+ctr).show(0);
    $("#pmin"+ctr).show(0);
    $("#pmout"+ctr).show(0);
  }
  else {
    $("#amin"+ctr).hide(0);
    $("#amout"+ctr).hide(0);
    $("#pmin"+ctr).hide(0);
    $("#pmout"+ctr).hide(0);
  }
}
// OTHER FUNCTIONS :: END