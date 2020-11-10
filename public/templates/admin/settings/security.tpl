
{if $message}
        <div class="alert card-alert {if $message.result == 'success'}alert-success{else}alert-danger{/if} alert-dismissible">
            <button type="button" class="close" data-dismiss="alert"></button>
            <i class="fe {if $message.result == 'success'}fe-check{else}fe-alert-triangle{/if} mr-2" aria-hidden="true"></i>{$message.message}
        </div>
        <br />
{/if}
<form action="/settings" method="POST">
    <input type="hidden" name="action" value="change_pass">
    <input type="hidden" name="id" value="{$user.employee_id}">
    <div class="row">
        <div class="col-lg-6">
            <h4>Change Password</h4>
            <hr />
            <div class="col-md-12">
                <div class="form-group">
                    <label class="form-label">Current Password</label>
                    <input type="password" class="form-control" name="current_pass" required>
                </div>
            </div>
            <div class="col-md-12">
                <div class="form-group">
                    <label class="form-label">New Password</label>
                    <input type="password" class="form-control" name="new_pass" required>
                </div>
            </div>
            <div class="col-md-12">
                <div class="form-group">
                    <label class="form-label">Confirm New Password</label>
                    <input type="password" class="form-control" name="confirm_pass" required>
                </div>
            </div>
            <div class="form-group">
                <span style="float: right;">
                <input type="submit" class="btn btn-primary" value="Submit">
                </span>
            </div>
        </div>
    </div>
</form>