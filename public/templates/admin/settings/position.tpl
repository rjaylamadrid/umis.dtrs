<div class="row">
    <div class="col-lg-12">
        <div class="card">
            <div class="card-body">
                <form action='' method = 'POST' id="frmData">
                    <input type="hidden" name="action" value="show_position">
                    <div class="form-group form-inline m-0">
                        <select class="custom-select" name="emp_type" onchange="show_list()">
                            <option value="1" {if $type == '1'}selected{/if}>Permanent | Teaching</option> 
                            <option value="2" {if $type == '2'}selected{/if}>Permanent | Non-Teaching</option> 
                            <option value="5" {if $type == '5'}selected{/if}>COS | Teaching</option>
                            <option value="6" {if $type == '6'}selected{/if}>COS | Non-Teaching</option>
                            <option value="7" {if $type == '7'}selected{/if}>Project-based</option>
                        </select>   
                    </div>
                </form>
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
                    {foreach $positions as $position}
                        <tr onclick='editposition({$position.position_code})'>
                            <td>{$position.position_code}</td>
                            <td>{$position.position_desc}</td>
                            <td>{$position.salary_grade}</td>
                            <td>{$position.salary|number_format:2:".":","}</td>
                            <td class="text-center"><div class="item-action dropdown">
                                <a href="javascript:void(0)" data-toggle="dropdown" class="icon" aria-expanded="false"><i class="fe fe-more-vertical"></i></a>
                                <div class="dropdown-menu dropdown-menu-right" x-placement="bottom-end" style="position: absolute; transform: translate3d(-181px, 20px, 0px); top: 0px; left: 0px; will-change: transform;">
                                    <a href="#" class="dropdown-item"><i class="dropdown-icon fe fe-edit"></i> Edit 
                                    </a>
                                    <a href="#" class="dropdown-item"><i class="dropdown-icon fe fe-trash"></i> Remove
                                    </a>
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
<script>
    require (['datatables'], function () {
        $("#tbl-positions").DataTable();
    })
</script>
{* <div class="modal fade margin-top-70" id="position-modal" role="dialog" tabindex="-1" style="margin-left:-50px;">
    <div class="modal-dialog" id="position" role="document" style="max-width: 500px;">
    </div>
</div> *}