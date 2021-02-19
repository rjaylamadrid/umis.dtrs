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
  f (form, "text", "/settings").then( function(html){
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
// OTHER FUNCTIONS :: END

//MESSAGES :: START
var msgTo, msgFrom;
var msgData = [];
var msgNotif = 0;

  var conn = new WebSocket('ws://' + window.location.origin.substr(7) + ':8080');
  if(typeof $("#user").val() !== "undefined"){
    conn.onopen = function(e) {
      conn.send(JSON.stringify({command: "active", user: $("#user").val()}));
      conn.send(JSON.stringify({command: "unseen", user: $("#user").val()}));
    }
  }

conn.onmessage = function(e) {
  var msg = JSON.parse(e.data);
  if(msg.command == "subscribe"){
    getMessages(msg.employee, msg.messages);
    $("#feed").animate({ scrollTop: $('#feed')[0].scrollHeight}, 1000);
  }else if(msg.command == "message"){
    newMessage(msg.message[0]);
    $("#feed").animate({ scrollTop: $('#feed')[0].scrollHeight}, 1000);
  }else if(msg.command == "active"){
    for(let employee of msg.online_users){ 
      getContacts(employee);
    }
  }else if(msg.command == "unseen"){
    msgNotif = 0;
    for (let index = 0; index < msg.index; index++) {
      if(typeof msg.unseen_msg[index] !== "undefined"){
        msgNotif = parseInt(msg.unseen_msg[index].unseen) + parseInt(msgNotif);
        getUnseen(msg.unseen_msg[index]);
      }
    }
    $("#notif").text(msgNotif);
  }
};

function getUnseen (item){
  $("#isSeen" + item.no).text(item.unseen == 0 ? '' : item.unseen);
}

function getContacts (item) {
  var status = item.status == 'active' ? 'bg-green' : 'bg-red';
  $("#isActive" + item.no).addClass('avatar-status ' + status);
}
function getMessages(employee, messages) {
  $("#chatName").text(employee[0].first_name + ' ' + employee[0].last_name);
  $("#chatEmail").text(employee[0].email_address);
  for(let msg of messages){
    newMessage(msg);
  }
}
function getSelectedEmployee(id) {
  msgTo = id;
  msgFrom = $("#user").val();
  conn.send(JSON.stringify({command: "subscribe", from: msgFrom, to: msgTo}));
  f (form, "text", "/attendance").then( function(html){
    $('#update-log-modal').modal('hide');
    init_dtr($('#id').val());
  });
  $("#feed").html("<ul></ul>");
}

$("#message").keypress(function (event){
  var keycode = (event.keycode ? event.keycode : event.which)
  
  if(keycode == '13') {
    event.preventDefault();
    var msg = {
      command: "message",
      from: msgFrom,
      to: msgTo,
      created_on: new Date(),
      text: $("#message").val(),
    };
    conn.send(JSON.stringify(msg));
    $("#message").val("");
    newMessage(msg);
    $("#feed").animate({ scrollTop: $('#feed')[0].scrollHeight}, 1000);
  }
});

$("#msgSearch").keypress(function (event){
  var keycode = (event.keycode ? event.keycode : event.which)
  console.log("test");
  
});

function newMessage(msg) {
  var HTMLList;
  var msgStatus = msgFrom == msg.from ? 'received' : 'sent';
 
  HTMLList =  "<li class='message " + msgStatus + "'>" +
                "<small class='dateTime'>" + fmtDateTime(new Date(msg.created_on.toString().substr(0, 10) + ", " + msg.created_on.toString().substr(11))) + "</small>" +
                "<div class='text'>" + msg.text + "</div>" +
              "</li>";
$("#feed").append("<ul>" + HTMLList + "</ul>"); 
}

function fmtDateTime(dt) {
  var day, month, year, hours, minutes, dateTime, ampm, dtNow, fmtDate;
  dtNow = date_create(new Date().getFullYear(), new Date().getMonth() + 1, new Date().getDate())
  day = dt.getDate();
  month = dt.getMonth() + 1;
  year = dt.getFullYear();
  day = day < 10 ? '0' + day : day;
  month = month < 10 ? '0' + month : month;

  hours = dt.getHours();
  minutes = dt.getMinutes();
  ampm = hours >= 12 ? 'PM' : 'AM';
  hours = hours % 12;
  hours = hours ? hours : 12;
  minutes = minutes < 10 ? '0' + minutes : minutes;

  if(year + '-' + month + '-' + day == dtNow){
    dateTime = hours + ':' + minutes + ' ' + ampm;
  }else{
    dateTime = month + '/' + day +'/' + year + ' AT ' + hours + ':' + minutes + ' ' + ampm;
  }
  return dateTime;
}
//MESSAGES :: END