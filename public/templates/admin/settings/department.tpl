
<div class="row row-cards row-deck">
    <div class="col-12">
    <a href="javascript:AddDepartment();" data-bs-toggle="modal" data-bs-target="#AddDepartment" class="ml-auto btn btn-primary mb-3"><i class="fe fe-plus"></i> Add Department</a>
        <div class="card">
            <div class="table-responsive">
                <table style=" font-family:  Arial;" class="table table-hover card-table table-vcenter text-nowrap datatable dataTable no-footer" id="tbl-positions">
                    <thead>
                        <tr>
                            <th>Department Code</th>
                            <th>Department name</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                  
                {foreach from=$department item=departments}
                        <tr id="refesh{$departments.no}">
                            <td class="col-sm-3" id="dept_code{$departments.no}" contenteditable="true" onfocus="showEdit({$departments.no});">{$departments.department_code}</td>
                            <td class="col-sm-10" id="dept_desc{$departments.no}" contenteditable="true" onfocus="showEdit({$departments.no});">{$departments.department_desc}</td>   
                            <td>
                                    <div class="dept_items" id="dept_item{$departments.no}" hidden="true">
                                        <span class="float-right ml-5">
                                        <span class="mr-5">
                                        <input id="dept_active{$departments.no}" class="form-check-input float-right" type="checkbox"{if ($departments.department_status == 1)}checked{/if}>
                                        <span  class="form-check-label is-invalid font-weight-bold">Active</span>
                                        </span>
                                        <input id="dept_projectbase{$departments.no}" class="form-check-input float-right" type="checkbox"  {if ($departments.is_project == 1)}checked{/if}>
                                        <span class="form-check-label is-invalid font-weight-bold" >Project base</span>
                                        <button  type="button" class="btn btn-primary btn-sm my-0" onclick="updateDepartment({$departments.no});"><i id ="updateIcon{$departments.no}" class="fe fe-save"></i><div id="UpdateSpinner{$departments.no}" class="spinner-border spinner-border-sm text-light" hidden></div> Update</button>
                                        </span>
                                    </div>

                            </td>
                            
                        </tr>
                {/foreach}
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

{include file="admin/modal/update_dept_modal.tpl"}

<script>
    require (['datatables'], function () {
        $("#tbl-positions").DataTable();
    })
</script>
