<!-- Update Schedule Modal -->
<div class="modal fade" id="ModalUpdate" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
<div class="modal-dialog modal-lg modal-dialog-centered" role="document">
  <div class="modal-content">
    <div class="modal-header text-black" >
    <h2 style="margin:0" id="Upmodal_name"><i class="dropdown-icon fe fe-calendar"></i>EDIT SCHEDULE - <span id="edit_name"></span></h2>
    
    </div>
    
    <div class="modal-body">
    <div class="col-12">
    <div class="card" >
        <div class="row">
        
        <div id ="selectalert" class="container col-lg-8 mt-2 text-center alert alert-success fade show" style="display: none;"><strong></strong></div>
      
        <div class="row col-lg-6 ml-2">
            <div  id ="Myselect">
            {include file="templates/custom/presetselect.tpl"}
            </div>             
        </div>
                <div class="row col-lg-6 mt-3" id="datemin" >
                  {include file="templates/custom/dateMin.tpl"}
                </div>
    
        </div> 
    
    <div class="table-responsive" id ="Update">
    {include file="templates/custom/tableschedule.tpl"}
    </div>
    </div>
    </div>
      </div>
     
        <div class="modal-footer">
        <input class="btn btn-danger text-white" type="submit" data-dismiss="modal" value="Close">    
        <input  id ="btn_effdate" class="btn btn-primary" onclick="SaveChanges()" type="submit" value="Submit" disabled>

        </div>
      </div>
    </div>
  </div>
</div>