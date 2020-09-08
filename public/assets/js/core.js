let path = document.location.href;

async function fetch (data = {}, url = path) {
  const response = await fetch(url, {
    method: 'POST',
    body: new URLSearchParams(data),
    headers: new Headers({ 'Content-type': 'application/x-www-form-urlencoded; charset=UTF-8' }),
  });
  return response;
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

    $.ajax({
        type:'POST',
        url:'attendance',
        data:{'action': 'get_attendance', 'id':id, 'month':month, 'year':year, 'period':period},
        success:function(data) {
            $("#dtr").html(data);
            $("#cover-spin").hide(0);
          $("#emp_active").val(id);
        }
      });
  }
}
// ATTENDANCE::END