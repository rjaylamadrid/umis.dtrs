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
    period = document.getElementById("period").value;
    from = document.getElementById("date_from").value;
    to = document.getElementById("date_to").value;
    f({action: 'get_attendance', id:id, date_from:from, date_to:to, period:period}, "text").then( function(html){
      $("#dtr").html(html);
      $("#cover-spin").hide(0);
    });
  }
}
// ATTENDANCE::END

// EMPLOYEE PROFILE :: START
function show_collapse(id,id_='#') {
  if (id_ == '.') {
    if($(id_+id).hasClass('collapse')){
      $(id_+id).removeClass('collapse');
      $('.head'+id).removeClass('fe-chevron-down');
      $('.head'+id).addClass('fe-chevron-up');
    }else{
      $(id_+id).addClass('collapse');
      $('.head'+id).addClass('fe-chevron-down');
      $('.head'+id).removeClass('fe-chevron-up');
    }
  } else {
    if($(id_+id).hasClass('collapse')){
      $(id_+id).removeClass('collapse');
      $('.'+id).removeClass('fe-chevron-down');
      $('.'+id).addClass('fe-chevron-up');
    }else{
      $(id_+id).addClass('collapse');
      $('.'+id).addClass('fe-chevron-down');
      $('.'+id).removeClass('fe-chevron-up');
    }
  }
}

function confirm_delete(no, id, tab, other_info_col='', other_info_data='', admin_id='') {
  if(confirm("Are you sure you want to delete this record?")) {
    if(tab=='other-info') {
      f({action: 'delete_row', no:no, tab:tab, other_info_col:other_info_col, other_info_data:other_info_data, admin_id:admin_id}, "text", "/employees").then( function (data) {
        location.href = "/employees/update/" + id + "/" + tab;
      });
    }
    else if(tab=='service_record') {
      f({action: 'delete_row', no:no, tab:'status'}, "text", "/employees").then( function (data) {
        location.href = "/employees/employment-update/" + id + "/" + tab;
      });
    }
    else {
      f({action: 'delete_row', no:no, tab:tab}, "text", "/employees").then( function (data) {
        location.href = "/employees/update/" + id + "/" + tab;
      });
    }
  }
}

function dual_citizenship(value) {
  console.log(value);
  if(value != 'Filipino') {
    $('#dual_citizen').attr('readonly',false);
    $('#dual_citizen').attr('required',true);
  }
  else {
    $('#dual_citizen').attr('readonly',true);
    $('#dual_citizen').val('');
  }
}

function set_emp_inactive(id,status,name,pos) {
  $('#emp_id').val(id);
  $('#status').val(status);
  $('#emp_name').val(name);
  $('#emp_pos').val(pos);
  $('#set-employee-inactive-modal').modal('show');
}
// EMPLOYEE PROFILE :: END

// CALENDAR :: START
  function get_events(day,month,year) {
    $('.spinner1').show(0);
    $('.date').removeClass('selected');
    $('#'+day).addClass('selected');
    day = (day < 10 ? "0" : "") + day;
    month = (month < 10 ? "0" : "") + month;
    document.getElementById('event_date').value = year+'-'+month+'-'+day;
    // document.getElementById('event_date_edit').value = year+'-'+month+'-'+day;
    f({action: 'show_events', day:day, month:month, year:year}, "text", "/calendar").then( function (data) {
      $('.spinner1').hide(0);
      $('#tbl-event').html(data);
      // console.log(data);
    });
  }

  function delete_event(no) {
    if(confirm("Are you sure you want to delete this event?")) {
      $('#cover-spin').show(0);
      f({action: 'delete_event', no:no}, "text", "/calendar").then( function (data) {
        $('#cover-spin').hide(0);
        // console.log(data);
      });
    }
  }
// CALENDAR :: END

// LEAVE :: START
function date_max()
{
 var maxDate = $('#date_to').val();

 $('#date_from').attr('max', maxDate);

 console.log(maxDate);
}

function date_min()
{
 var minDate = $('#date_from').val();

 $('#date_to').attr('min', minDate);

 console.log(minDate);
}


function dtmin(dtmin) {
 var min = $('#date_from').val();
 //document.getElementById("date_to").min = min;


 var d2 = new Date($('#date_to').val());
 var d1 = new Date($('#date_from').val());

 var Millis1 = d1.getTime();
 var Millis2 = d2.getTime();

 var diff = Math.abs(d1-d2);
 var Totaldays = Math.floor(diff/8.64e7);
 var days = 0;
 var weeks = Math.floor(days/7);
 var weekend = 0;

 var wd1 = d1.getDay();
 var wd2 = d2.getDay();

 for (var i = Millis1; i < Millis2; i+=8.64e7) 
 {
   var currentDate = new Date(i);
   if(currentDate.getDay() == 5 || currentDate.getDay() == 6)
   {
     weekend ++;
   }
 }
// days = (Totaldays + 1) - weekend;
// console.log(days);
dtmin.no_of_working_days.value = (Totaldays + 1) - weekend;
}

function toggle_other (option) {
  if (option == 1) {
    $("#vacation_text").prop("disabled", false);
    $("#vacation_text").val("");
  } else if (option == 2) {
    $("#vacation_text").prop("disabled", true);
    $("#vacation_text").val("");
  } else if (option == 3) {
   $("#where_specific").prop("disabled", true);
   $("#where_specific").val("");
  } else if (option == 4) {
  // $("#vacation_text").prop("disabled", true);
  // $("#vacation_text").val("");
  $("#where_specific").prop("disabled", false);
  $("#where_specific").val("");
  }
}

function toggle_options (option) {
  var options = '';
  $("#optionb").html("");
  if (option == 1) {
    $("#seek_employment").prop("disabled", false);
    $("#vacation_other").prop("disabled", false);
    $("#other_type_text").prop("disabled", true);
    $("#other_type_text").val("0");
    options = '<label class="form-label"> (In case of Vacation Leave)</label><label class="custom-control custom-radio"><input required type="radio" id="phonly" onchange="toggle_other(3)" class="custom-control-input radio_type" name="leave_info[lv_where]" value="Within the Philippines"><div class="custom-control-label">Within the Philippines</div></label><label class="custom-control custom-radio"><input required type="radio" id="abroad" onchange="toggle_other(4)" class="custom-control-input radio_type" name="leave_info[lv_where]" value="Abroad"><div class="custom-control-label">Abroad (Specify below)</div></label><input type="text" id="where_specific" disabled="true" class="form-control ml-1" name="leave_info[lv_where_specific]">';
  } else if (option == 2) {
    $("#seek_employment").prop("checked", false);
    $("#vacation_other").prop("checked", false);
    $("#seek_employment").prop("disabled", true);
    $("#vacation_other").prop("disabled", true);
    $("#vacation_text").prop("disabled", true);
    $("#other_type_text").prop("disabled", true);
    $("#other_type_text").val("0");
    $("#vacation_text").val("");

    options = '<label class="custom-control custom-radio"><input required type="radio" id="hospital" class="custom-control-input radio_type" name="leave_info[lv_where]" value="In Hospital"><div class="custom-control-label">in Hospital (Specify below)</div></label><label class="custom-control custom-radio"><input required type="radio" id="outpatient" class="custom-control-input radio_type" name="leave_info[lv_where]" value="Out Patient"><div class="custom-control-label">Out Patient (Specify below)</div></label><input type="text" id="where_specific" required class="form-control ml-1" name="leave_info[lv_where_specific]">';
  } else {
    $("#seek_employment").prop("disabled", true);
    $("#vacation_other").prop("disabled", true);
    $("#seek_employment").prop("checked", false);
    $("#vacation_other").prop("checked", false);
    $("#other_type_text").prop("disabled", false);
    options += '<input type="text" id="where_specific" required class="form-control ml-1" name="leave_info[lv_where_specific]">';
  }
  
  $("#optionb").html(options);
}

function delete_leave(id) {
  if(confirm("Are you sure you want to delete this leave request?")) {
    // $('#cover-spin').show(0);
    f({action: 'delete_leave', id:id}, "text", "/leave").then( function (data) {
      location.href = "/leave";
      // $('#cover-spin').hide(0);
      // console.log(data);
    });
  } else {
    return false;
  }
}

function disapp(disapp) {
  disapp.remarks.disabled = disapp.approved.checked == false ? false : true;
}

function change_emp(emp_info) {
  var emp_array = emp_info.split(";");
  document.getElementById(emp_array[5]+"pic").src = "/assets/employee_picture/"+emp_array[1];
  $("#"+emp_array[5]+"emp_id").val(emp_array[0]);
  $("#"+emp_array[5]+"position").val(emp_array[3]);
  $("#"+emp_array[5]+"department").val(emp_array[4]);
}

function forced_leave_change(emp_info) {
  $('#cover-spin').show(0);
  var emp_array = emp_info.split(";");
  var emp_id = emp_array[0];

  f({action: 'show_leave_credits', emp_id:emp_id}, "text", "/leave").then( function (data) {
    $('.spinner1').hide(0);
    $('#leave-credits').html(data);
  });

  document.getElementById(emp_array[5]+"pic").src = "/assets/employee_picture/"+emp_array[1];
  $("#"+emp_array[5]+"emp_id").val(emp_array[0]);
  $("#"+emp_array[5]+"position").val(emp_array[3]);
  $("#"+emp_array[5]+"department").val(emp_array[4]);
  $("#"+emp_array[5]+"emp_salary").val(emp_array[6]);
  $("#"+emp_array[5]+"dept").val(emp_array[4]);
}

// LEAVE :: END

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
    $('#positions').html("<option selected disabled>Position</option>");
    positions.forEach(function (position){
        $('#positions').append("<option value='" + position['no'] + "'>" + position['position_desc'] + "</option>");
        $('#salary').val("Php 0.00");
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
  var emp_type = $('#emp_type').val();
  f ({
    action: 'get_salary', position_id:position, date_start:date, emp_type:emp_type
  }, "text", "/employees").then( function(html) {
    $('#salary').val("Php " + html.toString());
  });
}

function customDate () {
  var period = $('#period_type').val();
  var presets = [['01','15'], ['16', '31'], ['01', '31']];

  if (period == "4") {
    $('#preset').addClass("d-none");
    $('#custom').removeClass("d-none");
  } else {
    var month = $('#mon').val();
    var year = $('#yr').val();
    $('#from').val(date_create(year, month, presets[period-1][0]));
    $('#to').val(date_create(year, month, presets[period-1][1]));
    console.log(date_create(year, month, presets[period-1][1]));
    $('#preset').removeClass("d-none");
    $('#custom').addClass("d-none");
  }
}

function setDate () {
  var month = $('#month').val();
  var year = $('#year').val();
  $('#date_from').val(date_create(year, month, 01));
  $('#date_to').val(date_create(year, month, 31));
}

function date_create(year, month, day) {
  month = month - 1;
  var date = day == '31' ? new Date(year,month+1,0) : new Date(year,month,day);
  y = date.getFullYear();
  m = date.getMonth();
  d = date.getDate();
  m  = m+1;
  return y + '-' + (m > 9 ? m : '0'+ m) + '-' + (d > 9 ? d : '0'+ d); 
}

function set_from (from) {
  $('#to').attr('min',create_date (from,'day', 1));
  $('#to').attr('max',create_date (from, 'day',30));
  $('#to').value(create_date (from, 'day',30));
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

function modify_log () {
  var form = $('#formLog').serialize();
  f (form, "text", "/attendance").then( function(html){
    $('#update-log-modal').modal('hide');
    init_dtr($('#id').val());
  });
}

function show_list () {
  var form = $('#frmData').serialize();
  f (form, "text", "/payroll").then( function(html){
    $('#settings_tab').html(html);
  });
}

function set_presets (type, emp_id = "") {
  $("#cover-spin").show(0);
  from = document.getElementById("date_from").value;
  to = document.getElementById("date_to").value;
  f({
    action:"set_default", emp_type:type, date_from:from, date_to:to, employee_id:emp_id 
  }, "text", "/attendance").then( function (html) {
    $("#cover-spin").hide(0);
    if (emp_id) {
      init_dtr(emp_id);
    } else {
      location.reload(true);
    }
  });
}

function show_settings() {
  if($('#settings-menu').hasClass("collapse")) {
    $('#settings-menu').removeClass("collapse");
  } else {
    $('#settings-menu').addClass("collapse");
  }
}

function payroll(action) {
  var payroll = [payroll_type = $('#payroll_type').val(),
  employee_type = $('#emp_type').val(),
  date_from = $('#date_from').val(),
  date_to = $('#date_to').val()];

  if (action == 'download_payroll') {
    $.post('/payroll',  {action:action, payroll:payroll}, function(){});
  }
  // f({action:action,payroll:payroll}, "text", "/payroll").then( function(html) {
  //   console.log(html);
  // })
}

// OTHER FUNCTIONS :: END
