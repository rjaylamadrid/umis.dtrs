//MESSAGES :: START
if(typeof $("#user").val() !== "undefined"){
  var sender, receiver, receiver_picture;
  var msgNotif = 0;
  var user_id = $("#user").val();
  var session_id = document.cookie.match(/PHPSESSID=[^;]+/);
  var onlineUsers = [], contactsData = new Array();
  var msg_id = 0;
  var appendOnceTyping = true;
  async function f_msg (data = {}, type = 'json', url = path) {
    const response = await fetch(url, {
      method: 'POST',
      body: new URLSearchParams(data),
      headers: new Headers({ 'Content-type': 'application/x-www-form-urlencoded; charset=UTF-8' }),
    });
    return type == 'json' ? response.json() : response.text();
  }

  f_msg({action: 'get_contacts', user_id: user_id }, "json", "/messages").then( function (data) {
    $("#contacts").html("<ul class='list-unstyled list-separated'></ul>");
    index = 0;
    for(let contact of data.contacts){
      showContacts(contact);
      index++;
    } 
    contactsData.unshift(data.contacts);
  });
  
  f_msg({action: 'get_recents', user_id: user_id }, "json", "/messages").then( function (data) {
    $("#recents").html("<ul class='list-unstyled list-separated'></ul>");
    for(let recent of data.recents){
      showRecents(recent);
    }  
  });

  // f_msg({action: 'get_online_users', user_id: user_id}, "json", "/messages").then( function (data) {
  //   for(let user of data.users){
  //     go_online(user);
  //   }
  // });

  f_msg({action: 'get_unseen_msg', user_id: user_id}, "json", "/messages").then( function (data) {
  console.log(data.unseen);
    for(let us of data.unseen){
      unSeenMsg(us);
    }
  });

  f_msg({action: 'get_message_notif', user_id: user_id}, "json", "/messages").then( function (data) {
    $("#notif").text(data.message_notif[0]['tlt_unseen'] == 0 ? '' : data.message_notif[0]['tlt_unseen']);
    msgNotif = data.message_notif[0]['tlt_unseen'];
  });

    // var conn = new WebSocket('ws://' + window.location.origin.substr(7) + ':9001?'+ session_id + '&user_id='+ user_id);
    var conn = new WebSocket('ws://192.168.2.222:9001?'+ session_id + '&user_id='+ user_id);
      conn.onopen = function(e) {
        console.log("connection establish");
    }

  conn.onmessage = function(e) {
    var msg = JSON.parse(e.data);
    if(msg.command == "login_user"){
      go_online(msg.users);
      onlineUsers.unshift(msg.users);
    }else if(msg.command == "logout_user"){
      go_offline(msg);
    }else if(msg.command == "msg_unseen"){
      for(let us of msg.unseen){unSeenMsg(us[0]);}
    }else if(msg.command == "message"){
      if(msg.status){
        f_msg({action: 'get_unseen_msg', user_id: user_id}, "json", "/messages").then( function (data) {
          for(let us of data.unseen){
            unSeenMsg(us);
          }
        });
        console.log(msgNotif);
        msgNotif = parseInt(msgNotif) + 1;
        $("#notif").text(msgNotif == 0 ? '' : msgNotif);
      }else{
        $(".typing").remove();
        if(msg.typing){
          var msgStatus = user_id == msg.from ? 'you' : 'other';
          var avatar = user_id == msg.to ? "<div id='r_isActive309' class='avatar d-block' style='background-image: url(/assets/employee_picture/" + msg.employee_picture + ")'></div>" : '';
          var HTMLList =  "<div class='message-row " + msgStatus + "-message typing'>" +
                      "<div class='message-content'>" +
                        avatar +
                        "<div class='message-text text-muted'>" + msg.text + "</div>" +
                      "</div>" +
                    "</div>";
        $("#chat-message-list").append(HTMLList);
        }else{
          if(msg.text == ''){
            $(".typing").remove();
          }else{
            $(".typing").remove();
            newMessage(msg);
          }
        }
        // console.log(msg);
        $("#chat-message-list").animate({ scrollTop: $('#chat-message-list')[0].scrollHeight}, 1000);
        f_msg({action: 'get_recents', user_id: user_id }, "json", "/messages").then( function (data) {
          $("#recents").html("<ul class='list-unstyled list-separated'></ul>");
          for(let recent of data.recents){
            showRecents(recent);
        
          }
        });
        go_online(onlineUsers[0]);
      }
    }
  };

  

  function showRecents (item) {
    var upper = item.first_name.charAt(0).toUpperCase() + item.first_name.slice(1).toLowerCase();
    var BoldText = item.Status == 1 ? "<b>" + upper+": "+item.ReplyText + "</b>" :upper +": "+item.ReplyText
    let itemtext = item.from == item.FromReply ? "You: "+ item.ReplyText:BoldText;
    if(itemtext.length >= 30){    
      itemtext = itemtext.substring(0,20) + "...";
      }
    var recentDate = itemtext + " • "+"<span class='message-time'>" + fmtDateTime(new Date(item.created_on.toString().substr(0, 10) + ", " + item.created_on.toString().substr(11)))+"</span>";
    var HTMLList =  "<li class='list-separated-item' onclick='javascript:selectMsgReceiver(" + item.no + ")' style='cursor: pointer;'>" +
                      "<div class='row align-items-center'>" +
                        "<div clas s='col-auto'>" +
                          "<div id='r_isActive" + item.no + "' class='avatar d-block' style='background-image: url(/assets/employee_picture/" + item.employee_picture + ")'>" +
                            "<span class='avatar-status bg-red'></span>" +
                          "</div>" +
                        "</div>" +
                        "<div class='col'>" +
                          "<span id='isSeen" + item.no + "' class='float-right badge badge-danger' style='border-radius:40px;'></span>" +
                          "<div><small class='d-block item-except text-sm h-1x' style='font-weight:bold'>"+ item.first_name.toUpperCase() + ' ' + item.last_name.toUpperCase()+"</small></div>" +
                          "<small class='d-block item-except text-mute text-sm h-2x'>" +
                            recentDate 
                          + "</small>" +
                        "</div>" +
                      "</div>" +
                    "</li>";
                    
    $("#recents").append("<ul class='list-unstyled list-separated'>" + HTMLList + "</ul>");
  };

  function showContacts (item) {
    var HTMLList =  "<li class='list-separated-item' onclick='javascript:selectMsgReceiver(" + item.no + ")' style='cursor: pointer;'>" +
                      "<div class='row align-items-center'>" +
                        "<div class='col-auto'>" +
                          "<div id='c_isActive" + item.no + "' class='avatar d-block' style='background-image: url(/assets/employee_picture/" + item.employee_picture + ")'>" +
                            "<span class='avatar-status bg-red'></span>" +
                          "</div>" +
                        "</div>" +
                        "<div class='col'>" +
                        // "<span id='isSeen" + item.no + "' class='mt-2 float-right badge badge-danger'></span>" +
                          "<div id='unseenMes'><small class='d-block item-except text-sm h-1x'>"+ item.first_name.toUpperCase() + ' ' + item.last_name.toUpperCase() +"</small></div>" +
                        "</div>" +
                      "</div>" +
                    "</li>";
                    
    $("#contacts").append("<ul class='list-unstyled list-separated'>" + HTMLList + "</ul>");
  }

  function unSeenMsg (item){
    $("#isSeen" + item.from).text(item.status == 0 ? '': item.status );
  }

  function go_online (items) {
    
    setTimeout(function () {
      for(let item of items){
        $( "#r_isActive" + item).html("<span class='avatar-status bg-green'></span>");
        $( "#c_isActive" + item).html("<span class='avatar-status bg-green'></span>");
      }
    }, 1000);

  }

  function go_offline (item) {
    $( "#r_isActive" + item.user_id ).html("<span class='avatar-status bg-red'></span>");
    $( "#c_isActive" + item.user_id ).html("<span class='avatar-status bg-red'></span>");
  }

  function getMessages(employee, messages) {
    $("#chatName").text(employee[0].first_name + ' ' + employee[0].last_name);
    $("#chatEmail").text(employee[0].email_address);
    for(let msg of messages){
      newMessage(msg);
    }
  }
  function selectMsgReceiver(receiver_id) {
    $("#message").removeAttr('hidden',false);
    $("#btnSend").removeAttr('hidden',false);
    localStorage.setItem('receiver_id',receiver_id);
    receiver = receiver_id;
    conn.send(JSON.stringify({command: "subscribe", sender_id: user_id, receiver_id: receiver_id}));
    $("#chat-message-list").html(""); 
    f_msg({action: 'get_receiver_info', receiver_id: receiver_id}, "json", "/messages").then( function (data) {
      $("#chatName").text(data.receiver_info[0].first_name + ' ' + data.receiver_info[0].last_name);
      $("#chatEmail").text(data.receiver_info[0].email_address);
 
      var HTMLList =  "<div class='col-auto'>" +
                        "<div id='c_isActive" + data.receiver_info[0].no + "' class='avatar d-block' style='background-image: url(/assets/employee_picture/" + data.receiver_info[0].employee_picture + ")'>" +
                          "<span class='avatar-status bg-red'></span>" +
                        "</div>" +
                      "</div>" +
                      "<div class='col'>" +
                        "<span id='isSeen" + data.receiver_info[0].no + "' class='mt-2 float-right badge badge-danger'></span>" +
                        "<div><small class='d-block item-except text-sm h-1x'>"+ data.receiver_info[0].first_name.toUpperCase() + ' ' + data.receiver_info[0].last_name.toUpperCase() +"</small></div>" +
                      "</div>";
      $("#selectedUser").html("<div class='row align-items-center'>" + HTMLList + "</div>");
      receiver_picture = data.receiver_info[0].employee_picture;
    });
    f_msg({action: 'get_recents', user_id: user_id }, "json", "/messages").then( function (data) {
      $("#recents").html("<ul class='list-unstyled list-separated'></ul>");
      for(let recent of data.recents){
        showRecents(recent);
      }  
    });

    f_msg({action: 'get_conversation', sender_id: user_id, receiver_id: receiver_id}, "json", "/messages").then( function (data) {
      for(let convo of data.conversation){ 
        newMessage(convo);
        appendOnceTyping = true
      }
      $("#chat-message-list").animate({ scrollTop: $('#chat-message-list')[0].scrollHeight}, 1000);
    });

    f_msg({action: 'update_msg_status', sender_id: receiver_id, receiver_id: user_id}, "json", "/messages").then( function (data) {
      // console.log(data.message_notif[0]['tlt_unseen']);
      $("#isSeen" + receiver_id).text('');
      if(data.message_notif[0]['tlt_unseen']){
        $("#notif").text(data.message_notif[0]['tlt_unseen'] == 0 ? '' : data.message_notif[0]['tlt_unseen']);
        msgNotif = data.message_notif[0]['tlt_unseen'];
      }
      go_online(onlineUsers[0]);
    });
  }
  $("#searchForRecents").keyup(function () {
    f_msg({action: 'search_recents', user_id: user_id, search_data: $("#searchForRecents").val() }, "json", "/messages").then( function (data) {
      $("#recents").html("<ul class='list-unstyled list-separated'></ul>");
      for(let recent of data.recents){
        showRecents(recent);
      }
    });
    go_online(onlineUsers[0]);
  });

  $("#searchForContacts").keyup(function () {
    f_msg({action: 'search_contacts', user_id: user_id, search_data: $("#searchForContacts").val()}, "json", "/messages").then( function (data) {
      $("#contacts").html("<ul class='list-unstyled list-separated'></ul>");
      // console.log(data);
      for(let contact of data.contacts){
        showContacts(contact);
      }
      go_online(onlineUsers[0]);
    });
  });

  // $("#message").focus(function(){
  //   receiver = localStorage.getItem('receiver_id');
  //   f_msg({action: 'update_msg_status',sender_id: user_id,receiver_id:receiver}, "json", "/messages").then( function (data) {
  //     // console.log(data.message_notif[0]['tlt_unseen']);
  //     // $("#msgSeen" + receiver).html('');
  //     if(data.message_notif[0]['tlt_unseen']){
  //   $("#notif").text(data.message_notif[0]['tlt_unseen'] == 0 ? '' : data.message_notif[0]['tlt_unseen']);
  //       msgNotif = data.message_notif[0]['tlt_unseen'];
  //     }
  //   });
  // });

  $("#message").keyup(function (event){
    
    $("#btnSend").removeAttr('disabled',false);
    var keycode = (event.keycode ? event.keycode : event.which);
    if(keycode == '13') {
      event.preventDefault();
      var msg = {
        action: "add_new_message",
        command: "message",
        from: user_id,
        to: receiver,
        text: $("#message").val(),
        status:false,
      };
      f_msg(msg, "json", "/messages").then( function (data) {
        newMessage(data.new_message[0]);
        data.new_message[0]['command'] = "message";
        data.new_message[0]['msg_id'] = msg_id;
        console.log(data.new_message[0]['msg_id']);
        conn.send(JSON.stringify(data.new_message[0]));
      });
      
      msg_id++;
      $("#message").val("");
      $("#chat-message-list").animate({ scrollTop: $('#chat-message-list')[0].scrollHeight}, 1000);
      f_msg({action: 'get_recents', user_id: user_id }, "json", "/messages").then( function (data) {
        $("#recents").html("<ul class='list-unstyled'></ul>");
        for(let recent of data.recents){
          showRecents(recent);
        }
      });
      go_online(onlineUsers[0]);
    }else if($("#message").val() == ""){
      $("#chat-message-list").animate({ scrollTop: $('#chat-message-list')[0].scrollHeight}, 1000);
      $("#btnSend").attr('disabled',true);
      var msg = {
        command: "message",
        from: user_id,
        to: receiver,
        text: "",
        typing:false,
        msg_id: msg_id
      };
      conn.send(JSON.stringify(msg));
    }else{
      var msg = {
        command: "message",
        from: user_id,
        to: receiver,
        text: "Typing...",
        typing:true,
        msg_id: msg_id
      };
      conn.send(JSON.stringify(msg));  
    }

  
  });

  function newMessage(msg) {
    var HTMLList;
    if((msg.to == receiver && msg.from == user_id) || (msg.to == user_id && msg.from == receiver)){

      // if(msg.text == "Typing..."){
      //   var msgStatus = user_id == msg.from ? 'you' : 'other';
      //   var checkUrl = isURL(msg.text) ? "<a class='message-text' target='_blank' href='" + msg.text + "'>" + msg.text + "</a>" : "<div class='message-text'>" + msg.text + "</div>";
      //   var avatar = user_id == msg.to ? "<div id='r_isActive309' class='avatar d-block' style='background-image: url(/assets/employee_picture/309.jpg)'></div>" : '';
      //   HTMLList =  "<div class='message-row " + msgStatus + "-message'>" +
      //                 "<div class='message-content'>" +
      //                   avatar +
      //                   "<div class='message-text text-muted'>" + msg.text + "</div>" +
      //                 "</div>" +
      //               "</div>";
      // }else{
      //   appendOnceTyping = true;
        var avatar = user_id == msg.to ? "<div id='r_isActive309' class='avatar d-block' style='background-image: url(/assets/employee_picture/" + msg.employee_picture + ")'></div>" :'';
        var msgNull = msg.text == '' ? '':"<div class='message-content text-break'>"+ avatar + "<div class='message-text text-break'>" + msg.text + "</div></div>";
        var msgStatus = user_id == msg.from ? 'you' : 'other';
        var msgSeen = user_id == msg.from && msg.status == 0 ? 'Seen ': '';
        var msgtimeNull = msg.text == ''? '':"<div id='msgSeen"+ user_id +"' class='message-time' style='margin-left:50px';>" + msgSeen + fmtDateTime(new Date(msg.created_on.toString().substr(0, 10) + ", " + msg.created_on.toString().substr(11))) + "</div>";
        var checkUrl = isURL(msg.text) ? "<a class='message-text text-break' target='_blank' href='" + msg.text + "'>" + msg.text + "</a>" :msgNull ;
        HTMLList ="<div class='message-row " + msgStatus + "-message'>" + msgNull + msgtimeNull  + "</div>";
        $("#chat-message-list").append(HTMLList);
    }
  }


  function fmtDateTime(dt) {
    var day, month, year, hours, minutes, dateTime, ampm, dtNow, fmtDate;
    var mS = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'June', 'July', 'Aug', 'Sept', 'Oct', 'Nov', 'Dec'];
    dtNow = date_create(new Date().getFullYear(), new Date().getMonth() + 1, new Date().getDate())
    day = dt.getDate();
    month = dt.getMonth() + 1;
    m_index = dt.getMonth();
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
      dateTime = mS[m_index] +' '+ day +', '+ year +" "+  hours + ':' + minutes + ' ' + ampm;
    }
    return dateTime;
  }
  function isURL(str) {
    var regexp = /(ftp|http|https):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%@!\-\/]))?/
    return regexp.test(str);
  }
}