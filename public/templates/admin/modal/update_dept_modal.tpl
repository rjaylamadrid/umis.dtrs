<div class="modal fade" id="AddDepartment1" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
    <div class="modal-header">
    <h3 class="modal-title">ADD DEPARTMENT</h3>
    <button type="button" class="close" data-dismiss="modal" aria-label="Close"></button>
    </div>
  <div id="alert"> </div>
   
 <div class="modal-body">
                    <div class="mb-3">
                    <label  for="Dep_code" class="form-label font-weight-bold">Department Code</label>
                    <input type="text" class="form-control" id="Dep_code">
                    </div>
                    <div class="mb-3">
                    <label  for="Dep_Desc" class="form-label font-weight-bold">Department Description</label>
                    <textarea class="form-control" id="Dep_Desc" rows="3"></textarea>
                    </div>
                    <div class="mb-3">
                        <label class="form-check">
                          <input id="projectBase" class="form-check-input" type="checkbox" false>
                          <span class="form-check-label is-invalid font-weight-bold">Project Base</span>
                        </label>
                    </div>
      </div>
      <div class="modal-footer">
      <button type="submit" class="btn btn-primary" onclick="addDeparment();">Submit</button> 
      </div>
    </div>
  </div>
</div>