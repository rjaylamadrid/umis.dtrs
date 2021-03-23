<div class="row">
    <div class="col-lg-12">
        <div class="card">
            <div class="card-body">
                <div class="d-flex">
                    <form action='' method = 'POST' id="frmData">
                        <input type="hidden" name="action" value="show_position">
                        <div class="form-group form-inline m-0">
                            <select class="custom-select" name="emp_type" onchange="show_list('settings')">
                                <option value="1" {if $emp_type == '1'}selected{/if}>Permanent | Teaching</option> 
                                <option value="2" {if $emp_type == '2'}selected{/if}>Permanent | Non-Teaching</option> 
                                <option value="5" {if $emp_type == '5'}selected{/if}>COS | Teaching</option>
                                <option value="6" {if $emp_type == '6'}selected{/if}>COS | Non-Teaching</option>
                                <option value="7" {if $emp_type == '7'}selected{/if}>Project-based</option>
                            </select>   
                        </div>
                    </form>
                    <a href="#" data-toggle="modal" data-target="#newPositionModal" class="ml-auto btn btn-primary">Create Position</a>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="row row-cards row-deck">
    <div class="col-12">
        <div class="card">
            <div class="table-responsive">
                <table style=" font-family:  Arial;" class="table table-hover card-table table-vcenter text-nowrap datatable dataTable no-footer" id="tbl-positions">
                    <thead>
                        <tr>
                            <th>Code</th>
                            <th>Position Name</th>
                            <th>Salary Grade</th>
                            <th>Base Salary</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                    {foreach $positions->positions as $position}
                        <tr>
                            <td>{$position.position_code}</td>
                            <td>{$position.position_desc}</td>
                            <td>{$position.salary_grade}</td>
                            <td>{$position.salary}{if $position.salary_type}/{$position.salary_type}{/if}</td>
                            <td class="float-right"><a href="#" class="icon" aria-expanded="false"><i class="fe fe-edit"></i></td>
                        </tr>
                    {/foreach}
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<script>
    require (['datatables'], function () {
        $("#tbl-positions").DataTable();
    })
</script>
<div class="modal fade margin-top-70" id="newPositionModal" role="dialog" tabindex="-1" style="margin-left:-50px;">
    <div class="modal-dialog" id="position" role="document" style="max-width: 500px;">
    </div>
</div>