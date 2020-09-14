<div class="modal fade" id="loginOtherAccountModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
          <button class="close" type="button" data-dismiss="modal" aria-label="Close">
          </button>
        </div>
        <div class="modal-body">Login to your {if $user.is_admin}Employee{else}Admin{/if} Account?</div>
        <div class="modal-footer">
          <form method="POST" action="/login">
            <input type="hidden" name="action" value="change_type">
            <input type="hidden" name="type" value="{if $user.is_admin}employee{else}admin{/if}">
            <a href="#" class="btn btn-pill btn-secondary" type="" data-dismiss="modal">Cancel</a>
            <button class="btn btn-primary btn-pill" name="otherAccount" type="submit" >Login as {if $user.is_admin}Employee{else}Admin{/if}</button>
          </form>
        </div>
      </div>
    </div>
</div>