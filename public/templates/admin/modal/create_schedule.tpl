<div class="modal fade margin-top-70" id="create-schedule-modal" role="dialog" tabindex="-1" style="margin-left:-180px;">
    <div class="modal-dialog" role="document">
        <div class="modal-content" style="width:800px;">
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title">Create New Work Schedule</h3>
                </div>
                <div class="card-body">
                    <form action="/employees" method="POST">
                        <input type="hidden" name="action" value="create_sched_preset">
                        <input type="hidden" name="id" value="{$employee->id}">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="form-label">Work Schedule Preset Name</label>
                                    <input type="text" class="form-control" name="schedule_preset[sched_day]" value="" placeholder="i.e. EVERYDAY" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="form-label">Work Schedule Preset Time</label>
                                    <input type="text" class="form-control" name="schedule_preset[sched_time]" value="" placeholder="i.e. 7:30 - 12:00 | 1:00 - 5:00" required>
                                </div>
                            </div>
                        </div>
                        <div class="table-responsive">
                            <table class="table card-table table-striped">
                                <thead>
                                    <tr><th>Day</th><th>AM IN</th><th>AM OUT</th><th>PM IN</th><th>PM OUT</th><th></th></tr>
                                </thead>
                                <tbody>
                                    {$days = array('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday')}
                                    {foreach from=$days item=day}
                                    <tr>
                                        <td><input type="checkbox" name="day[{$day@iteration}]" value="{$day}" id="day{$day@iteration}" onclick="javascript:create_sched({$day@iteration})" checked>{$day}</td>
                                        <td><input type="time" name="amin{$day@iteration}" id="amin{$day@iteration}"></td>
                                        <td><input type="time" name="amout{$day@iteration}" id="amout{$day@iteration}"></td>
                                        <td><input type="time" name="pmin{$day@iteration}" id="pmin{$day@iteration}"></td>
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
                                <button name="submit" value="submit" class="btn btn-primary">Save Work Schedule</button>
                                <a href="#" class="btn btn-secondary" data-dismiss="modal">Cancel</a>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>