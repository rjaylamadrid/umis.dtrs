{extends file="layout.tpl"}
{block name=title}Authentication{/block}
{block name=content}
    <div class="page-single" style="height:100vh">
        <div class="container">
            <div class="row">
                <div class="col col-login mx-auto">
                    <form class="card" action="" method="POST">
                        {if $error}<div class="card-alert alert alert-danger mb-0">{$error.message}</div>{/if}
                        <div class="card-body p-6">
                            <div class="card-title">Login to your account</div>
                                <div class="form-group">
                                    <label class="form-label">Email Address</label>
                                    <input type="text" name="username" class="form-control" autocomplete="username" placeholder="Enter email address" value="{if $error.type == '1'}{$frm['username']}{/if}">
                                </div>
                            <div class="form-group">
                                <label class="form-label">
                                    Password
                                </label>
                                <input type="password" name="password" class="form-control" autocomplete="current-password" placeholder="Password">
                            </div>
                            <div class="form-footer">
                                <button type="submit" name="" class="btn btn-primary btn-block">Sign in</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
{/block}