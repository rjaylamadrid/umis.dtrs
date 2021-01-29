{assign var=conn value=$var}
<div class="card">
    <div class="card-body" id="setting">
        <div class="row">
            <div class="col-lg-4">
                <label class="form-label">BIOMETRIC CONNECTION:</label>
                <form action="" method="POST">
                    <div class="form-fieldset">
                        <input type="hidden" name="action" value="save">
                        <div class="form-group">
                            <label class="form-label">Server IP Address</label>
                            <input type="text" name="setting[offline_server_ip]" class="form-control" data-mask="099.099.099.099" data-mask-clearifnotmatch="true" placeholder="000.000.000.000" autocomplete="off" maxlength="15" value="{$conn.offline_server_ip}">
                        </div>
                        <div class="form-group">
                            <label class="form-label">Username</label>
                            <input type="text" class="form-control" name="setting[offline_server_user]" placeholder="Text.." value="{$conn.offline_server_user}">
                        </div>
                        <div class="form-group">
                            <label class="form-label">Password</label>
                            <input type="password" class="form-control" name="setting[offline_server_password]" placeholder="Password.." value="{$conn.offline_server_password}">
                        </div>
                        <div class="form-group">
                            <button class="btn btn-primary btn-block">Save</button>
                        </div>
                    </div>
                </form>
            </div>
            <div class="col-lg-4">
                <label class="form-label">ONLINE CONNECTION:</label>
                <form action="" method="POST">
                    <div class="form-fieldset">
                        <input type="hidden" name="action" value="save">
                        <div class="form-group">
                            <label class="form-label">Server IP Address</label>
                            <input type="text" name="setting[online_server_ip]" class="form-control" data-mask="099.099.099.099" data-mask-clearifnotmatch="true" placeholder="000.000.000.000" autocomplete="off" maxlength="15" value="{$conn.online_server_ip}">
                        </div>
                        <div class="form-group">
                            <label class="form-label">Username</label>
                            <input type="text" class="form-control" name="setting[online_server_user]" placeholder="Text.." value="{$conn.online_server_user}">
                        </div>
                        <div class="form-group">
                            <label class="form-label">Password</label>
                            <input type="password" class="form-control" name="setting[online_server_password]" placeholder="Password.." value="{$conn.online_server_password}">
                        </div>
                        <div class="form-group">
                            <button class="btn btn-primary btn-block">Save</button>
                        </div>
                    </div>
                </form>
            </div>
            <div class="col-lg-3">
            </div>
        </div>
    </div>
</div>