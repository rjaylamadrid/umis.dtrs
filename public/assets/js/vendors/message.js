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
    console.log(msg.message[0].status);
    if(msg.message[0].status){
      var unseen = parseInt(msg.message[0].status) + parseInt(msgNotif)
      getUnseen({no: msg.message[0].from, unseen: unseen});
      msgNotif = parseInt(msg.message[0].status) + parseInt(msgNotif);
    }
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
  }else if(msg.command == "unseenTo"){
     console.log(msg);
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