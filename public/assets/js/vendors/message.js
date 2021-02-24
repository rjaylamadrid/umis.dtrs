//MESSAGES :: START
if(typeof $("#user").val() !== "undefined"){
var msgTo, msgFrom;
var msgData = [];
var msgNotif = 0;
var user_id = $("#user").val();
var session_id = document.cookie.match(/PHPSESSID=[^;]+/);
  var conn = new WebSocket('ws://' + window.location.origin.substr(7) + ':8080?'+ session_id + '&user_id='+ user_id);
  console.log(conn);
    conn.onopen = function(e) {
      //conn.send(JSON.stringify({command: "active", user: $("#user").val()}));
      //conn.send(JSON.stringify({command: "msg_unseen", user: $("#user").val()}));
    }

conn.onmessage = function(e) {
  var msg = JSON.parse(e.data);
  if(msg.command == "contacts_recents"){
    console.log("hey");
    $("#recents").html("<ul class='list-unstyled'></ul>");
    for(let recent of msg.recents){recents(recent);}
    $("#contacts").html("<ul class='list-unstyled'></ul>");
    for(let contact of msg.contacts){contacts(contact);}
  }else if(msg.command == "active_users"){
    for(let user of msg.users){activeUser(user);}
  }else if(msg.command == "msg_unseen"){
    console.log(msg);
    for(let us of msg.unseen){
      unSeenMsg(us[0]);
    }
  }else if(msg.command == "subscribe"){
    getMessages(msg.employee, msg.messages);
    $("#feed").animate({ scrollTop: $('#feed')[0].scrollHeight}, 1000);
    conn.send(JSON.stringify({command: "msg_unseen", user_id: user_id}));
  }else if(msg.command == "message"){
    newMessage(msg.message[0]);
    if($('#feed').is(":visible")){
      $("#feed").animate({ scrollTop: $('#feed')[0].scrollHeight}, 1000);
    }
    conn.send(JSON.stringify({command:"msg_unseen", user_id: msg.message[0].to}));
  }
  // if(msg.command == "subscribe"){
  //   getMessages(msg.employee, msg.messages);
  //   $("#feed").animate({ scrollTop: $('#feed')[0].scrollHeight}, 1000);
  // }else if(msg.command == "message"){
  //   newMessage(msg.message[0]);
  //   console.log(msg.message[0].status);
  //   if(msg.message[0].status){
  //     var unseen = parseInt(msg.message[0].status) + parseInt(msgNotif)
  //     getUnseen({no: msg.message[0].from, unseen: unseen});
  //     msgNotif = parseInt(msg.message[0].status) + parseInt(msgNotif);
  //   }
  //   $("#feed").animate({ scrollTop: $('#feed')[0].scrollHeight}, 1000);
  // }else if(msg.command == "initialize"){

  //   $("#recents").html("<ul class='list-unstyled'></ul>");
  //   for(let recent of msg.recents){recents(recent);}

  //   $("#contacts").html("<ul class='list-unstyled'></ul>");
  //   for(let contact of msg.contacts){contacts(contact);}

  //   for(let user of msg.users){activeUser(user);}
    
  //   //for(let us of msg.unseen){unSeenMsg(us[0]);}
    
  // }else if(msg.command == "unseen"){
  //   msgNotif = 0;
  //   for (let index = 0; index < msg.index; index++) {
  //     if(typeof msg.unseen_msg[index] !== "undefined"){
  //       msgNotif = parseInt(msg.unseen_msg[index].unseen) + parseInt(msgNotif);
  //       unSeenMsg(msg.unseen_msg[index]); 
  //     }
  //   }
  //   $("#notif").text(msgNotif);
  // }else if(msg.command == "unseenTo"){
  //    console.log(msg);
  // }
};

function recents (item) {
  var HTMLList =  "<li class='list-separated-item' onclick='javascript:getSelectedEmployee(" + item.no + ")'>" +
                    "<div class='row align-items-center'>" +
                      "<div class='col-md-2'>" +
                        "<div id='isActive" + item.no + "' class='avatar d-block' style='background-image: url(/assets/employee_picture/" + item.employee_picture + ")'>" +
                        "</div>" +
                      "</div>" +

                      "<div class='col-md-10'>" +
                        "<span id='isSeen" + item.no + "' class='mt-2 float-right badge badge-danger'></span>" +
                        "<div>"+ item.first_name + ' ' + item.last_name +"</div>" +
                        "<div class='small text-muted'>" + item.text + "</div>" +
                      "</div>" +
                    "</div>" +
                  "</li>" 

  $("#recents").append("<ul class='list-unstyled'>" + HTMLList + "</ul>");
}

function contacts (item) {
  if(item.no != user_id) {
  var HTMLList =  "<li class='list-separated-item' onclick='javascript:getSelectedEmployee(" + item.no + ")'>" +
                    "<div class='row align-items-center'>" +
                      "<div class='col-md-2'>" +
                        "<div id='isActive" + item.no + "' class='avatar d-block' style='background-image: url(/assets/employee_picture/" + item.employee_picture + ")'>" +
                        "</div>" +
                      "</div>" +

                      "<div class='col-md-10'>" +
                        "<span id='isSeen" + item.no + "' class='mt-2 float-right badge badge-danger'></span>" +
                        "<div>"+ item.first_name + ' ' + item.last_name +"</div>" +
                        "<div class='small text-muted'>" + item.email_address + "</div>" +
                      "</div>" +
                    "</div>" +
                  "</li>" 

  $("#contacts").append("<ul class='list-unstyled'>" + HTMLList + "</ul>");
  }
}

function unSeenMsg (item){
  if(item.cnt_unseen >= 0){
    $("#isSeen" + item.from).text(item.cnt_unseen == 0 ? '' : item.cnt_unseen);
  }else{
    $("#notif").text(item.tlt_unseen);
  }
  
}

function activeUser (item) {
  var status = item.active == 1 ? 'bg-green' : 'bg-red';
  $( "#isActive" + item.no ).html("<span class='avatar-status " + status + "'></span>");
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
  $("#feed").html("<ul></ul>"); 
  conn.send(JSON.stringify({command: "unseen", user: $("#user").val()}));
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
    conn.send(JSON.stringify({command:"recents", user_id: user_id}));
  }
});

$("#msgSearch").keypress(function (event){
  var keycode = (event.keycode ? event.keycode : event.which)
  console.log("test");
  
});

function newMessage(msg) {
  if((msg.to == msgTo && msg.from == msgFrom) || (msg.to == msgFrom && msg.from == msgTo)){
  var HTMLList;
  var msgStatus = msgFrom == msg.from ? 'received' : 'sent';
  
  HTMLList =  "<li class='message " + msgStatus + "'>" +
                "<small class='dateTime'>" + fmtDateTime(new Date(msg.created_on.toString().substr(0, 10) + ", " + msg.created_on.toString().substr(11))) + "</small>" +
                "<div class='text'>" + msg.text + "</div>" +
              "</li>";
$("#feed").append("<ul>" + HTMLList + "</ul>");
  }
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
}