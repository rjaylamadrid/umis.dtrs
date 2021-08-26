<!-- Update Schedule Modal -->
<div class="modal fade" id="ModalAddPreset" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
  <div class="modal-content">
        <div class="modal-header text-white bg-dark">
            <h2 class="m-0" >Create New Work Schedule</h2>
        </div>
         <div class="modal-body">
            <div class="card">
            <div id="create" class="container mt-4">
            <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="form-label">Work Schedule Preset Name</label>
                                    <input type="text" class="form-control" id="schedule_preset[sched_day]" value="" placeholder="i.e. EVERYDAY" required="">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="form-label">Work Schedule Preset Time</label>
                                    <input type="text" class="form-control" id="schedule_preset[sched_time]" value="" placeholder="i.e. 7:30 - 12:00 | 1:00 - 5:00" required="">
                                </div>
                            </div>
                        </div>    
         </div>
         <div class="table-responsive">
             <table class="table card-table table-center table-striped">
                                <thead>
                                    <tr>
                                    <th>Day</th>
                                    <th>AM IN</th>
                                    <th>AM OUT</th>
                                    <th>PM IN</th>
                                    <th>PM OUT</th>
                                    </tr>
                                </thead>
                                <tbody>
                            
                                                                                                            <tr>
                                        <td style="text-align: left;"><input type="checkbox" name="day[1]" value="Monday" id="day1" onclick="javascript:create_sched(1)" checked=""> Monday</td>
                                        <td><input type="time" name="amin1" id="amin1" class="form-control"></td>
                                        <td><input type="time" name="amout1" id="amout1" class="form-control"></td>
                                        <td><input type="time" name="pmin1" id="pmin1" class="form-control"></td>
                                        <td><input type="time" name="pmout1" id="pmout1" class="form-control"></td>
                                    </tr>
                                     <tr>
                                        <td style="text-align: left;"><input type="checkbox" name="day[2]" value="Tuesday" id="day2" onclick="javascript:create_sched(2)" checked=""> Tuesday</td>
                                        <td><input type="time" name="amin2" id="amin2" class="form-control"></td>
                                        <td><input type="time" name="amout2" id="amout2" class="form-control"></td>
                                        <td><input type="time" name="pmin2" id="pmin2" class="form-control"></td>
                                        <td><input type="time" name="pmout2" id="pmout2" class="form-control"></td>
                                    </tr>
                                                                        <tr>
                                        <td style="text-align: left;"><input type="checkbox" name="day[3]" value="Wednesday" id="day3" onclick="javascript:create_sched(3)" checked=""> Wednesday</td>
                                        <td><input type="time" name="amin3" id="amin3" class="form-control" class="form-control"></td>
                                        <td><input type="time" name="amout3" id="amout3" class="form-control" class="form-control"></td>
                                        <td><input type="time" name="pmin3" id="pmin3" class="form-control" class="form-control"></td>
                                        <td><input type="time" name="pmout3" id="pmout3" class="form-control" class="form-control"></td>
                                    </tr>
                                                                        <tr>
                                        <td style="text-align: left;"><input type="checkbox" name="day[4]" value="Thursday" id="day4" onclick="javascript:create_sched(4)" checked=""> Thursday</td>
                                        <td><input type="time" name="amin4" id="amin4" class="form-control"></td>
                                        <td><input type="time" name="amout4" id="amout4" class="form-control"></td>
                                        <td><input type="time" name="pmin4" id="pmin4" class="form-control"></td>
                                        <td><input type="time" name="pmout4" id="pmout4" class="form-control"></td>
                                    </tr>
                                                                        <tr>
                                        <td style="text-align: left;"><input type="checkbox" name="day[5]" value="Friday" id="day5" onclick="javascript:create_sched(5)" checked=""> Friday</td>
                                        <td><input type="time" name="amin5" id="amin5" class="form-control"></td>
                                        <td><input type="time" name="amout5" id="amout5" class="form-control"></td>
                                        <td><input type="time" name="pmin5" id="pmin5" class="form-control"></td>
                                        <td><input type="time" name="pmout5" id="pmout5" class="form-control"></td>
                                    </tr>
                                                                        <tr>
                                        <td style="text-align: left;"><input type="checkbox" name="day[6]" value="Saturday" id="day6" onclick="javascript:create_sched(6)" checked=""> Saturday</td>
                                        <td><input type="time" name="amin6" id="amin6" class="form-control"></td>
                                        <td><input type="time" name="amout6" id="amout6" class="form-control"></td>
                                        <td><input type="time" name="pmin6" id="pmin6" class="form-control"></td>
                                        <td><input type="time" name="pmout6" id="pmout6" class="form-control"></td>
                                    </tr>
                                                                        <tr>
                                        <td style="text-align: left;"><input type="checkbox" name="day[7]" value="Sunday" id="day7" onclick="javascript:create_sched(7)" checked=""> Sunday</td>
                                        <td><input type="time" name="amin7" id="amin7" class="form-control"></td>
                                        <td><input type="time" name="amout7" id="amout7" class="form-control"></td>
                                        <td><input type="time" name="pmin7" id="pmin7" class="form-control"></td>
                                        <td><input type="time" name="pmout7" id="pmout7" class="form-control"></td>
                                    </tr>
                                 
                         </tbody>
                            </table>
                            <br>
                            <i>Tick or untick the check boxes to include or remove the corresponding day in the work schedule preset being created.</i>
                        </div>
         </div>    
         </div>
        <div class="modal-footer">
        <a href="javascript:SaveWorkSchedule()" class="btn btn-primary"><i class="fe fe-calendar"></i> Save Work Schedule</a>
        <a data-dismiss="modal" href="" class="btn btn-danger"><i class="fe fe-x"></i> Close</a>
          
        </div>
      </div>
    </div>
  </div>
  