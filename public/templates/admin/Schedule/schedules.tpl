{extends file="layout.tpl"}
{block name=content} 

<div class=" card container mt-4 ">  
<div class="d-flex justify-content-end">
<a href="javascript:addpreset()" class="btn btn-primary col-lg-3 mt-5 "><i class="fe fe-calendar"></i> Add Work Schedule</a>
</div>

  <table style=" font-family:  Arial;" class="table table-hover card-table  text-nowrap datatable dataTable no-footer" id="tbl-employees">

  <thead>
          <th class="sorting_asc" tabindex="0" aria-controls="tbl-positions" rowspan="1" colspan="1" aria-sort="ascending" style="width: 20%;">ID NO.</th>
          <th class="sorting" tabindex="0" aria-controls="tbl-positions" rowspan="1" colspan="1"  style="width:   60%;">Name</th>
          <th tabindex="0" aria-controls="tbl-positions" rowspan="1" colspan="1"  style="width: 100px;">Position</th>  
          <th rowspan="1" colspan="1" style="width: 100px;">Status</th>
          <th rowspan="1" colspan="1" >Action</th>
          </th>
      </thead>
      <tbody>
        {foreach from=$infos item=info}
          <tr role="row" class="odd">
                  <td class="sorting_1">{$info.employee_id}</td>
                  <td id = "Fullname{$info.no}"> {$info.last_name|upper}, {$info.first_name|upper} {$info.middle_name|upper}<span style="margin-left: 30px;"></span></td>
                  <td>{$info.position_desc|upper}</td>
                  <td>
                  {foreach from=$Status item=status }
                    {if $info.no == $status.no}
                        {if $status.Status == 1}
                          <span class="badge bg-success">{$status.sched_code}</span>
                          
                       {elseif $status.Status == 0}
                        <a href="javascript:activateStatus({$info.no})"><span class="badge bg-danger">{$status.sched_code}</span></a>
                        {/if  }
                        
                    {/if }
                  {/foreach}
                  </td>
                  <td>
                  <a href="javascript:Get_id({$info.no})" class="icon"><i class="fe fe-eye"></i></a>
                  <a href="javascript:uSchedules({$info.no})" class="icon"><i class="fe fe-edit"></i></a>
                  </td>
                  
          </tr>
        {/foreach}
      </tbody> 
  </table>
</div>

<!-- Show Schedule Modal -->
<div class="modal fade" id="ViewSched" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header text-white bg-dark" id="full_name">
       {include file="admin/Schedule/Name.tpl"}
      </div>
      <div class="modal-body">
      <div class="col-12">
        <div class="table-responsive" id ="sched">
          {include file="admin/Schedule/Modal/View_Sched.tpl"}
          </div>
        </div>
          </div>

          
          <div class="modal-footer">
         
            <button type="button" class="btn text-white bg-dark" data-dismiss="modal">CLOSE</button>
          </div>
        </div>
      </div>
    </div>
    <form method="POST">
    {include file="admin/Schedule/Modal/AddPresetSchedules.tpl"}
    </form>


  <!-- Update Schedule Modal -->
<div class="modal fade" id="ModalUpdate" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
<div class="modal-dialog modal-lg modal-dialog-centered" role="document">
  <div class="modal-content">
    <div class="modal-header text-white bg-dark" id="full_name1">
    {include file="admin/Schedule/Name.tpl"}
    </div>
    <div class="modal-body">
    <div class="col-12">
    <div class="card">
        <div class="row">
        
        <div id ="selectalert" class="container col-lg-8 mt-2 text-center alert alert-success fade show" style="display: none;"><strong></strong></div>
        
      
      
                <div class="row col-lg-8 ml-2">
                    <div  id ="Myselect">
                      {include file="admin/Schedule/SelectOption.tpl"}
                      </div>             
                </div>
                <div class="row col-lg-4 mt-3" >
                <input id="effective_date" type="date" class="form-control" onChange="enableSubmit();" hidden> 
                </div>
        </div> 
    <div class="table-responsive" id ="Update">
        {include file="admin/Schedule/Modal/Update_Schedule.tpl"}
        </div>
        </div>
      </div>
     
        <div class="modal-footer">
        <input  id ="btn_effdate" class="btn btn text-white bg-dark" onclick="SaveChanges()" type="submit" value="Submit" disabled>
        <input class="btn btn text-white bg-dark" type="submit" data-dismiss="modal" value="Close">      
        </div>
      </div>
    </div>
  </div>
</div>

  <!-- Update Schedule Modal -->
  <div class="modal fade" id="ActivateStatus" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-sm modal-dialog-centered" role="document">
    <div class="modal-content">
    <div class="modal-header text-black bg-white" id="full_name1">
        <span><h5>Activate Pending Status<h5></span>
    </div>
    <div class="container mt-2">
      
          <p style="text-align: center;"><b>If you wish to activate this pending schedule click Yes, if not please discard?</b></p>
       
    </div>
  
          <div class="modal-footer">
          <input class="btn btn text-white bg-dark" type="submit" value="Yes">
          <input class="btn btn text-white bg-dark" type="submit" data-dismiss="modal" value="Discard">      
          </div>
        </div>
      </div>
    </div>

<script>
   require (['datatables'], function () {
       $("#tbl-employees").DataTable();
   });
</script>            

{/block}