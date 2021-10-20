<div class="modal fade margin-top-70" id="create-schedule-modal" role="dialog" tabindex="-1" style="margin-left:-180px;">
    <div class="modal-dialog" role="document">
        <div class="modal-content" style="width:800px;">
            <div class="card">
                <div id="card" class="card-header">
                    <h3 class="card-title">Create New Work Schedule</h3>
                </div><br>
                <div id ="insertmes" class="container col-lg-8 mt-2 text-center alert alert-success fade show" style="display: none;"><strong>Work Schedule Created Successfully!</strong></div>
                <div class="card-body">
                
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="form-label">Work Schedule Preset Name</label>
                                    <input type="text" class="form-control" id="schedule_preset[sched_day]"  onchange ="btnDisabled();" placeholder="i.e. EVERYDAY" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="form-label">Work Schedule Preset Time</label>
                                    <input type="text" class="form-control" id="schedule_preset[sched_time]"  onchange ="btnDisabled();" placeholder="i.e. 7:30 - 12:00 | 1:00 - 5:00" required>
                                </div>
                            </div>
                        </div>
                        <a href="javascript:applyTOall();" class="btn btn-primary  float-right" style="margin-right:52px" id="apply{$day}">Apply to all</a>
                        <div class="table-responsive">
                            <table class="table card-table table-striped">
                                <thead>  
                                    <tr class="text-center"><th>Day</th><th>AM IN</th><th>AM OUT</th><th>PM IN</th><th>PM OUT</th></tr>
                                </thead>
                                <tbody>
                                    {$days = array('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday')}
                                    {foreach from=$days item=day}
                                    <tr>
                                        <td><input type="checkbox" name="day[{$day@iteration}]" value="{$day}" id="day{$day@iteration}" onclick="javascript:create_sched({$day@iteration})" checked>  {$day}</td>
                                        <td><input type="time" name="amin{$day@iteration}" id="amin{$day@iteration}" ></td>
                                        <td><input type="time" name="amout{$day@iteration}" id="amout{$day@iteration}"></td>
                                        <td><input type="time" name="pmin{$day@iteration}" id="pmin{$day@iteration}" ></td>
                                        <td><input type="time" name="pmout{$day@iteration}" id="pmout{$day@iteration}"></td>   
                                    </tr>
                                    {/foreach}
                                </tbody>
                            </table>
                            <br />
                            <i>Tick or untick the check boxes to include or remove the corresponding day in the work schedule preset being created.</i>
                        </div>
                        <div class="col-md-12 mt-5">
                            <div class="form-group" style="float: right;">
                                <button id="insertBtn" name="button" value="submit" class="btn btn-primary" onclick="insert_schedule();" disabled>Save Work Schedule</button>
                                <a href="#" class="btn btn-secondary" data-dismiss="modal">Cancel</a>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>