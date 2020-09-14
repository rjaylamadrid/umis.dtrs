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
// OTHER FUNCTIONS :: END