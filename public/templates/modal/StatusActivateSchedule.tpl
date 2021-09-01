<!-- Update Schedule Modal -->
<div class="modal fade" id="ActivateStatus" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
<div class="modal-dialog modal-sm modal-dialog-centered" role="document">
  <div class="modal-content">
  <div class="modal-header">
  <h5 class="modal-title text-black bg-white">Activate Pending Status</h5>
      <button type="button" class="close" data-dismiss="modal" aria-label="Close">
      </button>
  </div>
  <div class="container mt-2">
          <div id ="activate" class="container" hidden >
          <p style="text-align: center;"><b>
           <span><i class="fe fe-check-circle text-green" style="font-size:60px;"></i></span><br>
          Schedule Pending is Activated
          </b></p>
          </div>

        <p id ="message" style="text-align: center;"><b>If you wish to activate this pending schedule click Yes, if not please Discard?</b></p>
     
  </div>

        <div class="modal-footer">
        
        <a id="btnYes" href="javascript:PendingActivate()" class="btn btn-success btn-sm"><i class="fe fe-check"></i> Yes</a>
        <a id="btnDismiss" href="" class="btn btn-danger btn-sm" data-dismiss="modal" ><i class="fe fe-x"></i> Discard</a>
            
        </div>
      </div>
    </div>
  </div>